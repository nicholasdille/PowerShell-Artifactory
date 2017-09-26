function Get-ArtifactStatistics {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute(
        "PSUseSingularNouns", 
        "", 
        Justification = "That's how it is called"
    )]
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Path
    )

    Invoke-ArtifactoryApi -Path "/api/storage/$($Path)?stats"
}