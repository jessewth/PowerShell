##################################################
# Use PowerShell checking your servers .NET Framwork CLR version
##################################################

cd c:\batch\ps1

$serverList = Get-Content .\shopping_server_list.txt

$objServerListInfo = @()

foreach ($server in $serverList) {

    # Get PowerShell version table
    #$serverPsVersionTable = Invoke-Command -ScriptBlock { $PSVersionTable } -ComputerName $server

    # Get .NET Framework installed version
    $dontNetVersion = Invoke-Command -ScriptBlock { Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4' -Recurse | Get-ItemProperty -Name Version -EA 0 | Select -exp Version -Unique } -ComputerName $server
    $dnotNetReleaseDWORD = Invoke-Command -ScriptBlock { Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4' -Recurse | Get-ItemProperty -Name Release -EA 0 | Select -exp Release -Unique } -ComputerName $server
    # Check On-Line Application Pool managedRuntimeVersion
    #$managedRuntimeVersion = Invoke-Command -ScriptBlock { Add-PSSnapin WebAdministration; Get-ItemProperty IIS:\AppPools\* | select managedruntimeversion -Unique | Sort-Object | Select-Object -Last 1 } -ComputerName $server

    $objServerInfo = New-Object System.Object
    $objServerInfo | Add-Member -Type NoteProperty -Name 'Machine Name' -Value $server
    #$objServerInfo | Add-Member -Type NoteProperty -Name 'CLRVersion' -Value $serverPsVersionTable.CLRVersion
    $objServerInfo | Add-Member -Type NoteProperty -Name '.NET Version' -Value $dontNetVersion
    $objServerInfo | Add-Member -Type NoteProperty -Name 'Release DWORD' -Value $dnotNetReleaseDWORD
    #$objServerInfo | Add-Member -Type NoteProperty -Name 'IIS AppPools managedRuntimeVersion' -Value $managedRuntimeVersion

    $objServerListInfo += $objServerInfo

}

$objServerListInfo | Export-Csv C:\batch\ps1\CheckServerCLREnvironment.csv