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

$sourceNode = $sourceAppSettings.connectionStrings.add

foreach ($node in $newAppSettings.connectionStrings.add) {

    $sourceNode = ($sourceAppSettings.connectionStrings.add | ? { 
        
        $sourceKey = $_.name -replace "QA.|Dev.|Prod.", ""
        $newKey = $node.name -replace "QA.|Dev.|Prod.", ""

        #$_.key -eq $node.key 
        $sourceKey -eq $newKey


    } | Select-Object -First 1)

    if ($sourceNode -ne $null) {
        
        if ($sourceNode.connectionString -ne $node.connectionString) {
            
            Write-Host "ConnectionString["$sourceNode.name"] = "$sourceNode.connectionString", replace to "$node.connectionString -ForegroundColor Yellow

            $sourceNode.connectionString = $node.connectionString
        }
    }
}

$sourceAppSettings.Save($sourceAppSettingsConfig)