@{
    # Script module or binary module file associated with this manifest.
    RootModule = 'New-mgdeviceManagementConfigurationPolicyGroupAssignment.psm1'

    # Version number of this module.
    ModuleVersion = '1.0.0'

    # Supported PSEditions
    CompatiblePSEditions = @('Desktop', 'Core')

    # ID used to uniquely identify this module
    GUID = 'efa64ea2-174b-406f-8ca8-e4d41fcc5afa'

    # Author of this module
    Author = 'CSerafinGit'

    # Company or vendor of this module
    CompanyName = 'Unknown'

    # Copyright statement for this module
    Copyright = '(c) 2026 CSerafinGit. All rights reserved. Licensed under GPL v3.'

    # Description of the functionality provided by this module
    Description = 'PowerShell module for creating group assignments for Microsoft Graph device management configuration policies.'

    # Minimum version of the PowerShell engine required by this module
    PowerShellVersion = '5.1'

    # Functions to export from this module
    FunctionsToExport = @('New-mgdeviceManagementConfigurationPolicyGroupAssignment')

    # Cmdlets to export from this module
    CmdletsToExport = @()

    # Variables to export from this module
    VariablesToExport = @()

    # Aliases to export from this module
    AliasesToExport = @()

    # Private data to pass to the module specified in RootModule/ModuleToProcess
    PrivateData = @{
        PSData = @{
            # Tags applied to this module for discovery
            Tags = @('Microsoft', 'Graph', 'DeviceManagement', 'ConfigurationPolicy', 'GroupAssignment', 'Intune', 'Azure')

            # A URL to the license for this module.
            LicenseUri = 'https://github.com/CSerafinGit/New-mgdeviceManagementConfigurationPolicyGroupAssignment/blob/main/LICENSE'

            # A URL to the main website for this project.
            ProjectUri = 'https://github.com/CSerafinGit/New-mgdeviceManagementConfigurationPolicyGroupAssignment'

            # ReleaseNotes of this module
            ReleaseNotes = 'Initial release of New-mgdeviceManagementConfigurationPolicyGroupAssignment module.'
        }
    }
}
