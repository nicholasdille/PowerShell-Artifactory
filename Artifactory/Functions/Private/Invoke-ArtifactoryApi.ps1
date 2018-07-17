#requires -Version 4
#requires -Modules WebRequest

function Invoke-ArtifactoryApi {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Path
        ,
        [Parameter()]
        [ValidateSet('Delete', 'Get', 'Post', 'Put')]
        [string]
        $Method = 'Get'
        ,
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [hashtable]
        $Headers = @{}
        ,
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]
        $Accept = 'application/json'
    )

    if ($Headers.ContainsKey('Accept')) {
        $Headers.Accept = $Accept

    } else {
        $Headers.Add('Accept', $Accept)
    }

    $Artifactory = Get-Artifactory

    $AuthString = Get-BasicAuthentication -User $Artifactory.User -Token $Artifactory.Token
    $IwrParams = @{
        Uri     = "$($Artifactory.Server)$Path"
        Method  = 'Get'
        Headers = @{
            Authorization = "basic $AuthString"
            Accept        = 'application/json'
        }
    }

    $bytes = Invoke-WebRequest -UseBasicParsing @IwrParams | Select-Object -ExpandProperty Content
    $response = [System.Text.Encoding]::ASCII.GetString($bytes) | ConvertFrom-Json
    $response
}