function Find-Artifact {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Path
        ,
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [int]
        $Depth = 1
    )

    Invoke-ArtifactoryApi -Path "/api/storage/$($Path)?list&deep=1&depth=$Depth&listFolders=1"
}
