@{
    RootModule = 'Artifactory.psm1'
    ModuleVersion = '0.1.14'
    GUID = '8869f6e6-aea3-426e-9db9-30f1a7521c2e'
    Author = 'Nicholas Dille'
    #CompanyName = ''
    Copyright = '(c) 2017 Nicholas Dille. All rights reserved.'
     Description = 'Cmdlets for JFrog Artifactory'
    # PowerShellVersion = ''
    RequiredModules = @(
        @{
            ModuleName = 'Helpers'
            RequiredVersion = '0.4.0.24'
        }
    )
    FunctionsToExport = @(
        'Set-Artifactory'
        'Find-Artifact'
        'Find-UnusedArtifact'
        'Find-UnusedDockerImage'
        'Get-Artifact'
        'Get-ArtifactStatistics'
        'Remove-Artifact'
    )
    CmdletsToExport = @()
    VariablesToExport = '*'
    AliasesToExport = @()
    #FormatsToProcess = @()
    PrivateData = @{
        PSData = @{
            # Tags = @()
            # LicenseUri = ''
            # ProjectUri = ''
            # ReleaseNotes = ''
        }
    }
}

