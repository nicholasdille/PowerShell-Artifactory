$Server = 'http://mvnrepository.grp.haufemg.com/artifactory'
$User   = 'dillen'
$Token  = 'AKCp2WXqtjzWjbPa7XaNnnkLGBUGsic6TR35nMcJGmou5tm4tAkwZvyZsf6N4LwLenhAyNh6N'
$Path   = 'docker-local2'

if (-not $Projects) {
    $Projects = Find-Artifact -Server $Server -User $User -Token $Token -Path $Path -Depth 1
}
if (-not $ProjectImages) {
    $ProjectImages = @()
    $Projects.files.uri | ForEach-Object {
        $ProjectPath = "$Path$_"
        $ProjectImages += Find-Artifact -Server $Server -User $User -Token $Token -Path $ProjectPath -Depth 3 | Select-Object -ExpandProperty files | ForEach-Object { "$ProjectPath$($_.uri)" }
    }
}

$Images = $ProjectImages | Where-Object { $_ -like '*/manifest.json' } | ForEach-Object {
    $NameItems = $_ -split '/'
    
    if ($NameItems.Length -eq 5) {
        [pscustomobject]@{
            Repository   = $NameItems[0]
            Project      = $NameItems[1]
            Image        = $NameItems[2]
            ProjectImage = "$($NameItems[1])/$($NameItems[2])"
            Tag          = $NameItems[3]
        }

    } elseif ($NameItems.Length -eq 4) {
        [pscustomobject]@{
            Repository   = $NameItems[0]
            Project      = ''
            Image        = $NameItems[1]
            ProjectImage = "/$($NameItems[1])"
            Tag          = $NameItems[2]
        }

    } else {
        Write-Warning "Unable to handle path '$_'"
    }
}

$Images | Group-Object -Property ProjectImage | Sort-Object -Property Count -Descending | Select-Object -Property Count,Name | Out-GridView