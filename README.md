# New-mgdeviceManagementConfigurationPolicyGroupAssignment

A PowerShell module for creating group assignments for Microsoft Graph device management configuration policies.

## Description

This module provides a function to create group assignments for device management configuration policies in Microsoft Graph. It allows you to assign configuration policies to Azure AD groups with include or exclude targeting.

## Installation

### From Source

1. Clone this repository:
   ```powershell
   git clone https://github.com/CSerafinGit/New-mgdeviceManagementConfigurationPolicyGroupAssignment.git
   ```

2. Import the module:
   ```powershell
   Import-Module .\New-mgdeviceManagementConfigurationPolicyGroupAssignment.psd1
   ```

### Prerequisites

- PowerShell 5.1 or later (PowerShell Core 7+ recommended)
- Microsoft.Graph.DeviceManagement module (recommended)

## Usage

### Basic Usage

Create a group assignment for a configuration policy:

```powershell
New-mgdeviceManagementConfigurationPolicyGroupAssignment -PolicyId "12345-abcde" -GroupId "67890-fghij"
```

### Advanced Usage

Create an exclusion group assignment:

```powershell
New-mgdeviceManagementConfigurationPolicyGroupAssignment -PolicyId "12345-abcde" -GroupId "67890-fghij" -Target "Exclude"
```

Use with pipeline:

```powershell
$policies | New-mgdeviceManagementConfigurationPolicyGroupAssignment -GroupId "67890-fghij"
```

### Parameters

- **PolicyId** (Required): The ID of the device management configuration policy
- **GroupId** (Required): The ID of the Azure AD group
- **Target** (Optional): Specifies the target type ('Include' or 'Exclude'). Default is 'Include'

### Examples

```powershell
# Example 1: Create an include assignment
New-mgdeviceManagementConfigurationPolicyGroupAssignment -PolicyId "abc123" -GroupId "xyz789"

# Example 2: Create an exclude assignment with verbose output
New-mgdeviceManagementConfigurationPolicyGroupAssignment -PolicyId "abc123" -GroupId "xyz789" -Target "Exclude" -Verbose

# Example 3: Using WhatIf to preview the operation
New-mgdeviceManagementConfigurationPolicyGroupAssignment -PolicyId "abc123" -GroupId "xyz789" -WhatIf
```

## Features

- ✅ Create group assignments for configuration policies
- ✅ Support for include and exclude targeting
- ✅ Pipeline support
- ✅ WhatIf and Confirm support
- ✅ Verbose logging
- ✅ Input validation
- ✅ Comprehensive help documentation

## License

This project is licensed under the GNU General Public License v3.0 - see the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Support

For issues, questions, or contributions, please open an issue on the [GitHub repository](https://github.com/CSerafinGit/New-mgdeviceManagementConfigurationPolicyGroupAssignment/issues).

## Author

CSerafinGit

## Version History

- **1.0.0** (2026-01-12): Initial release
