function Get-ArtifactStatistics {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Path
    )

    Invoke-ArtifactoryApi -Path "/api/storage/$($Path)?stats"
}