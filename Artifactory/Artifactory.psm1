$script:ArtifactoryServer = ''
$script:ArtifactoryUser   = ''
$script:ArtifactoryToken  = ''

Get-ChildItem -Path "$PSScriptRoot" -Filter '*.ps1' -Recurse | ForEach-Object {
    . "$($_.FullName)"
}