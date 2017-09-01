function Get-Artifact {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Path
    )

    $Content = Invoke-ArtifactoryApi -Path "/api/storage/$Path"
    $Content.children.uri
}
