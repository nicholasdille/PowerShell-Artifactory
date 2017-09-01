function Find-UnusedArtifact {
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

    # Use Get-Epoch
    $unixEpochStart = New-Object -TypeName DateTime -ArgumentList 1970,1,1,0,0,0,([DateTimeKind]::Utc)
    $UtcNow = [datetime]::UtcNow
    $Timestamp = [long]($UtcNow.AddDays(-1 * $AgeInDays) - $unixEpochStart).TotalMilliseconds

    $Response = Invoke-ArtifactoryApi -Path "/api/search/usage?notUsedSince=$Timestamp&repos=$Repository" -Accept '*/*'
    $Response.results
}