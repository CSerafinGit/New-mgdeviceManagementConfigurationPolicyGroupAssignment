# New-mgdeviceManagementConfigurationPolicyGroupAssignment

A PowerShell function to assign Microsoft Intune configuration policies to Entra ID groups via Microsoft Graph API.

## Overview

This function simplifies the process of assigning Intune configuration policies to Azure AD (Entra ID) groups. It intelligently handles existing assignments, preventing duplicates while preserving current group assignments.

## Features

- ✅ Assigns Intune configuration policies to Entra ID groups
- ✅ Preserves existing group assignments
- ✅ Prevents duplicate assignments
- ✅ Handles cases with no existing assignments
- ✅ Uses Microsoft Graph Beta endpoint
- ✅ Error handling with detailed warnings

## How It Works

1. **Retrieves** existing assignments for the specified policy
2. **Filters** for group-based assignment targets
3. **Checks** if the target group is already assigned
4. **Adds** the target group if not already present
5. **Posts** the updated assignment list back to Microsoft Graph

## Prerequisites

- **Microsoft Graph PowerShell SDK** installed
- **Permissions**:  `DeviceManagementConfiguration.ReadWrite.All`
- **Authentication**: Active Microsoft Graph session with appropriate scopes
- **Graph Endpoint**: `https://graph.microsoft.com/beta`

## Installation

1. Install the Microsoft Graph PowerShell SDK: 
```powershell
Install-Module Microsoft.Graph.DeviceManagement -Scope CurrentUser
```

2. Connect to Microsoft Graph with required permissions:
```powershell
Connect-MgGraph -Scopes "DeviceManagementConfiguration.ReadWrite.All"
```

3. Import or dot-source the function:
```powershell
.  .\New-mgdeviceManagementConfigurationPolicyGroupAssignment.ps1
```

## Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `policyId` | String | Yes | The GUID of the Intune configuration policy |
| `targetGroup` | String | Yes | The Object ID of the Entra ID group to assign |

## Usage

### Basic Syntax

```powershell
New-mgdeviceManagementConfigurationPolicyGroupAssignment -policyId "<policy-guid>" -targetGroup "<group-object-id>"
```

### Complete Example

```powershell
# Get all configuration policies
$AllConfigurationPolicies = Invoke-MgGraphRequest -Method Get -URI "https://graph.microsoft.com/beta/deviceManagement/configurationPolicies"

# Find specific policy by name
$ConfigurationPolicyID = $($AllConfigurationPolicies. value | Where-Object { $_. name -like "MyConfigurationPolicyName" }).id

# Get group ID by display name
$GroupID = $(Get-MgGroup -Filter "displayName eq 'MyGroupName'").Id

# Assign the policy to the group
New-mgdeviceManagementConfigurationPolicyGroupAssignment -policyId $ConfigurationPolicyID -targetGroup $GroupID
```

### Alternative Example with Direct IDs

```powershell
# Using known GUIDs
$PolicyId = "12345678-1234-1234-1234-123456789abc"
$GroupId = "87654321-4321-4321-4321-cba987654321"

New-mgdeviceManagementConfigurationPolicyGroupAssignment -policyId $PolicyId -targetGroup $GroupId
```

## Error Handling

The function includes try-catch blocks for:
- **GET requests**: Warns if unable to retrieve existing assignments
- **POST requests**:  Warns if unable to update assignments

Errors are displayed using `Write-Warning` with the exception message.

## Notes

- The function only works with **group-based assignments** (`#microsoft.graph.groupAssignmentTarget`)
- Other assignment types (e.g., all users, all devices) are preserved but not modified
- If the group is already assigned, the function skips adding it again
- The function uses the **beta** endpoint, which may have changes in the future

## API Endpoints Used

| Method | Endpoint | Purpose |
|--------|----------|---------|
| GET | `/deviceManagement/configurationPolicies/{id}/assignments` | Retrieve existing assignments |
| POST | `/deviceManagement/configurationPolicies/{id}/assign` | Update policy assignments |

## Troubleshooting

### "Insufficient privileges to complete the operation"
- Ensure you have `DeviceManagementConfiguration.ReadWrite.All` permission
- Reconnect with:  `Connect-MgGraph -Scopes "DeviceManagementConfiguration.ReadWrite.All"`

### "Resource not found"
- Verify the policy ID exists
- Verify the group ID is correct
- Check you're targeting the correct tenant

### No output/silent execution
- The function doesn't return output on success
- Check the Intune portal or use `GET` to verify assignments

## License

This project is provided as-is for use in Microsoft Intune environments.

## Contributing

Feel free to submit issues or pull requests for improvements.

---

**Author**: CSerafinGit  
**Repository**: [New-mgdeviceManagementConfigurationPolicyGroupAssignment](https://github.com/CSerafinGit/New-mgdeviceManagementConfigurationPolicyGroupAssignment)
