function Remove-Artifact {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact='High')]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Path
        ,
        [Parameter(Mandatory, ValueFromPipeline, ParameterSetName = 'Pipeline')]
        [ValidateNotNullOrEmpty()]
        [string[]]
        $Item
        ,
        [Parameter(Mandatory, ParameterSetName = 'Interactive')]
        [ValidateNotNullOrEmpty()]
        [switch]
        $Interactive
    )
    
    begin {
        if (-not $PSBoundParameters.ContainsKey('Confirm')) {
            $ConfirmPreference = $PSCmdlet.SessionState.PSVariable.GetValue('ConfirmPreference')
        }
        if (-not $PSBoundParameters.ContainsKey('WhatIf')) {
            $WhatIfPreference = $PSCmdlet.SessionState.PSVariable.GetValue('WhatIfPreference')
        }
    }

    process {
        if ($PSCmdlet.ParameterSetName -ieq 'Pipeline') {
            foreach ($subitem in $Item) {
                try {
                    if ($Force -or $PSCmdlet.ShouldProcess("Remove artifact '/$Path/$subitem'?")) {
                        Invoke-ArtifactoryApi -Path "/$Path/$subitem" -Method Delete | Out-Null
                    }

                } catch [System.Net.WebException] {
                    $response = $_.Exception.Response
                    Write-Error ('[{0}] Failed to remove {1} due to status code {2} ({3}).' -f $MyInvocation.MyCommand.Name, $response.ResponseUri, [int]($response.StatusCode), $response.StatusDescription)
                }
            }

        } elseif ($PSCmdlet.ParameterSetName -ieq 'Interactive') {
            Get-Artifact -Path $Path | Out-GridView -Title 'Select artifacts' -PassThru | Remove-Artifact -Path $Path
        }
    }
}