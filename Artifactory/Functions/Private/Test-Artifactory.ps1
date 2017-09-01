function Test-Artifactory {
    [CmdletBinding()]
    param()

    $script:ArtifactoryServer -and $script:ArtifactoryUser -and $script:ArtifactoryToken
}