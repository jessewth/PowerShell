param
(
    [Parameter(Mandatory = $true)] $sourceAppSettingsConfig,
    [Parameter(Mandatory = $true)] $newAppSettingsConfig
)

if ([string]::IsNullOrEmpty($sourceAppSettingsConfig)) {
    Write-Error "Please input source AppSettings.config" -ErrorAction Stop
}

if ([string]::IsNullOrEmpty($newAppSettingsConfig)) {
    Write-Error "Please input new AppSettings.config" -ErrorAction Stop
}

if (!(Test-Path $sourceAppSettingsConfig)) {
    Write-Error "Source AppSettings.config NOT EXISTS! " $sourceAppSettingsConfig -ErrorAction Stop
}

if (!(Test-Path $newAppSettingsConfig)) {
    Write-Error "New AppSettings.config NOT EXISTS! " $newAppSettingsConfig -ErrorAction Stop
}


$sourceAppSettings = [xml](Get-Content $sourceAppSettingsConfig -Encoding UTF8)
$newAppSettings = [xml](Get-Content $newAppSettingsConfig -Encoding UTF8)

$sourceNode = $sourceAppSettings.appSettings.add

$newAppSettings | % { 
    

}

foreach ($node in $newAppSettings.appSettings.add) {

    $sourceNode = ($sourceAppSettings.appSettings.add | ? { 
        
        $sourceKey = $_.key -replace "QA.|Dev.|Prod.", ""
        $newKey = $node.key -replace "QA.|Dev.|Prod.", ""

        #$_.key -eq $node.key 
        $sourceKey -eq $newKey


    } | Select-Object -First 1)

    if ($sourceNode -ne $null) {
        
        if ($sourceNode.value -ne $node.value) {
            
            Write-Host "AppSettings["$sourceNode.key"] = "$sourceNode.value", replace to "$node.value -ForegroundColor Yellow

            $sourceNode.value = $node.value
        }
    }
}

$sourceAppSettings.Save($sourceAppSettingsConfig)