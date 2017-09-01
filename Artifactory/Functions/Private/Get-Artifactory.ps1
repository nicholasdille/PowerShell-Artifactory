function Get-Artifactory {
    [CmdletBinding()]
    param()

    if (-Not (Test-Artifactory)) {
        throw 'Credentials not set. Please use Set-Artifactory first.'
    }

    @{
        Server = $script:ArtifactoryServer
        User   = $script:ArtifactoryUser
        Token  = $script:ArtifactoryToken
    }
}