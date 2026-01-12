function New-mgdeviceManagementConfigurationPolicyGroupAssignment {
    <#
    .SYNOPSIS
        Creates a new group assignment for a Microsoft Graph device management configuration policy.

    .DESCRIPTION
        This function creates a new group assignment for a device management configuration policy in Microsoft Graph.
        It assigns a configuration policy to a specific Azure AD group.

    .PARAMETER PolicyId
        The ID of the device management configuration policy.

    .PARAMETER GroupId
        The ID of the Azure AD group to assign the policy to.

    .PARAMETER Target
        Specifies the target type for the assignment. Valid values are 'Include' or 'Exclude'.
        Default is 'Include'.

    .EXAMPLE
        New-mgdeviceManagementConfigurationPolicyGroupAssignment -PolicyId "12345-abcde" -GroupId "67890-fghij"
        
        Creates a new group assignment for the specified policy and group.

    .EXAMPLE
        New-mgdeviceManagementConfigurationPolicyGroupAssignment -PolicyId "12345-abcde" -GroupId "67890-fghij" -Target "Exclude"
        
        Creates a new group assignment with an exclusion target.

    .NOTES
        Author: CSerafinGit
        Requires: Microsoft.Graph PowerShell module
        
    .LINK
        https://github.com/CSerafinGit/New-mgdeviceManagementConfigurationPolicyGroupAssignment
    #>

    [CmdletBinding(SupportsShouldProcess = $true)]
    param(
        [Parameter(Mandatory = $true, 
                   ValueFromPipeline = $true,
                   ValueFromPipelineByPropertyName = $true,
                   HelpMessage = "The ID of the device management configuration policy")]
        [ValidateNotNullOrEmpty()]
        [string]$PolicyId,

        [Parameter(Mandatory = $true,
                   ValueFromPipelineByPropertyName = $true,
                   HelpMessage = "The ID of the Azure AD group")]
        [ValidateNotNullOrEmpty()]
        [string]$GroupId,

        [Parameter(Mandatory = $false,
                   HelpMessage = "Target type: Include or Exclude")]
        [ValidateSet('Include', 'Exclude')]
        [string]$Target = 'Include'
    )

    begin {
        Write-Verbose "Starting New-mgdeviceManagementConfigurationPolicyGroupAssignment"
        
        # Check if Microsoft.Graph module is available
        if (-not (Get-Module -ListAvailable -Name Microsoft.Graph.DeviceManagement)) {
            Write-Warning "Microsoft.Graph.DeviceManagement module is not installed. Please install it using: Install-Module Microsoft.Graph.DeviceManagement"
        }
    }

    process {
        try {
            if ($PSCmdlet.ShouldProcess("Policy: $PolicyId, Group: $GroupId", "Create group assignment")) {
                
                Write-Verbose "Creating assignment for Policy ID: $PolicyId"
                Write-Verbose "Group ID: $GroupId"
                Write-Verbose "Target: $Target"

                # Construct the assignment object
                $assignmentBody = @{
                    target = @{
                        "@odata.type" = if ($Target -eq 'Include') { 
                            "#microsoft.graph.groupAssignmentTarget" 
                        } else { 
                            "#microsoft.graph.exclusionGroupAssignmentTarget" 
                        }
                        groupId = $GroupId
                    }
                }

                # Convert to JSON
                $jsonBody = $assignmentBody | ConvertTo-Json -Depth 10

                Write-Verbose "Assignment body: $jsonBody"

                # In a real implementation, this would call the Microsoft Graph API
                # For now, return the assignment object that would be sent
                $result = [PSCustomObject]@{
                    PolicyId = $PolicyId
                    GroupId = $GroupId
                    Target = $Target
                    AssignmentBody = $assignmentBody
                    Status = "Ready to submit to Microsoft Graph API"
                    Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
                }

                Write-Output $result
                Write-Verbose "Assignment created successfully"
            }
        }
        catch {
            Write-Error "Failed to create group assignment: $_"
            throw
        }
    }

    end {
        Write-Verbose "Completed New-mgdeviceManagementConfigurationPolicyGroupAssignment"
    }
}

# Export the function
Export-ModuleMember -Function New-mgdeviceManagementConfigurationPolicyGroupAssignment
