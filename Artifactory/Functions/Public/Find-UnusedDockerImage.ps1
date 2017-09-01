function Find-UnusedDockerImage {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Repository
        ,
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [int]
        $AgeInDays
    )

    $Data = Find-UnusedArtifact @PSBoundParameters

    $Pattern = '/api/storage/'
    $DownloadData = $Data | ForEach-Object {
        $RepoIndex = $_.uri.IndexOf($Pattern)
        $RelativeUri = $_.uri.Substring($RepoIndex + $Pattern.Length)
        $LayerIndex = $RelativeUri.IndexOf('/sha256__')
        if ($LayerIndex -ge 0) {
            $RelativeUri = $RelativeUri.Substring(0, $LayerIndex)
        }
        $ManifestIndex = $RelativeUri.IndexOf('/manifest.json')
        if ($ManifestIndex -ge 0) {
            $RelativeUri = $RelativeUri.Substring(0, $ManifestIndex)
        }

        [pscustomobject]@{
            Uri               = $RelativeUri
            DownloadTimestamp = $_.lastDownloaded
        }
    }

    $DownloadData | Group-Object -Property Uri | ForEach-Object {
        [pscustomobject]@{
            Uri       = $_.Name
            Timestamp = $_.Group.DownloadTimestamp | Measure-Object -Maximum | Select-Object -ExpandProperty Maximum
        }
    }
}