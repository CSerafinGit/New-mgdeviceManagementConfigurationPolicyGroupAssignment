<#
## New-mgdeviceManagementConfigurationPolicyGroupAssignment

Assigns an Intune configuration policy to an Entra ID group via Microsoft Graph.

## Parameters

- `policyId` (string, required): Configuration policy ID.
- `targetGroup` (string, required): Entra ID group object ID to assign.

## What it does
1. GETs existing assignments for the policy.
2. Collects group-based assignments.
3. Adds the target group if not already assigned.
4. POSTs the updated assignments to Graph.

## Requirements
- Microsoft Graph PowerShell SDK.
- Permission to read and write device management configuration. (DeviceManagementConfiguration.ReadWrite.All)
- Graph endpoint: `https://graph.microsoft.com/beta`.


## Usage
```powershell
New-mgdeviceManagementConfigurationPolicyGroupAssignment -policyId "<policy-guid>" -targetGroup "<group-object-id>"

## Example
$AllConfigurationPolicies = Invoke-MgGraphRequest -Method Get -URI https://graph.microsoft.com/beta/deviceManagement/configurationPolicies
$ConfigurationPolicyID = $($AllConfigurationPolicies.value | Where-Object { $_.name -like "MyConfigurationPolicyName" }).id
$GroupID = $(Get-MgGroup -Filter "displayName eq 'MyGroupName'").Id
New-mgdeviceManagementConfigurationPolicyGroupAssignment -policyId $ConfigurationPolicyID -targetGroup $GroupID
#>


function New-mgdeviceManagementConfigurationPolicyGroupAssignment {
    param (
        [Parameter(Mandatory = $true)]
        [string]$policyId,      # Target configuration policy ID

        [Parameter(Mandatory = $true)]
        [string]$targetGroup    # Azure AD group ID to assign
    )
   
    # Endpoints for fetching existing assignments and posting updates
    $getUri = "https://graph.microsoft.com/beta/deviceManagement/configurationPolicies/$($policyId)/assignments"
    $postUri = "https://graph.microsoft.com/beta/deviceManagement/configurationPolicies/$($policyId)/assign"

    try {
        # Retrieve current assignments for the policy
        $assignments = Invoke-MgGraphRequest -Method GET -Uri $getUri    
    }
    catch {
        Write-Warning $_.Exception.Message
    }

    # Filter to group-based assignment targets
    $groupAssignments = @($assignments.value | Where-Object { $_.target.'@odata.type' -eq "#microsoft.graph.groupAssignmentTarget" })

    # If no group assignments exist, prepare a new body with the requested group
    if (-not $groupAssignments) {
        $body = @{
            assignments = @(
                @{
                    "target" = @{
                        "@odata.type" = "#microsoft.graph.groupAssignmentTarget"
                        "groupId" = $targetGroup
                    }
                }
            )
        } | ConvertTo-Json -Depth 10
    }
   
    # Check if the target group is already assigned
    $alreadyAssigned = $groupAssignments | Where-Object { $_.target.groupId -eq $targetGroup }

    # Add the group if it is not already present
    if (-not $alreadyAssigned) {
        $groupAssignments += [PSCustomObject]@{
            target = @{
                "@odata.type" = "#microsoft.graph.groupAssignmentTarget"
                groupId = $targetGroup
            }
        }
    }

    # If we didn’t build a body earlier, rebuild it with existing + new assignments
    if (-not $body) {
        $body = @{
            assignments = @($groupAssignments | ForEach-Object {
                @{
                    target = @{
                        "@odata.type" = $_.target.'@odata.type'
                        groupId = $_.target.groupId
                    }
                }
            })
        } | ConvertTo-Json -Depth 10
    }

    try {
        # Submit the assignment payload
        Invoke-MgGraphRequest -Method POST -Uri $postUri -Body $body -ContentType "application/json"
    }
    catch {
        Write-Warning $_.Exception.Message
    }
}
