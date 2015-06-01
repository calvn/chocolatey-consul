try {
  $binariesPath = $(Join-Path (Split-Path -parent $MyInvocation.MyCommand.Definition) "..\binaries\")
  $toolsPath = (Split-Path -Parent $MyInvocation.MyCommand.Definition)

  # NSSM related variables
  $nssmPackageName = 'nssm'
  $nssmVersion = '2.24'
  $nssmSourcePath = $(Join-Path $binariesPath "nssm-$nssmVersion.zip")

  # Consul related variables
  $sourcePath = $(Join-Path $binariesPath "0.5.0_windows_386.zip")
  $sourcePathUI = $(Join-Path $binariesPath "0.5.0_web_ui.zip")

  # Install NSSM locally within consul
  Get-ChocolateyUnzip $nssmSourcePath $toolsPath

  $folderToIgnore = 'win32'
  $forderToRun = 'win64'

  if (Get-ProcessorBits 32) {
    $folderToIgnore = 'win64'
    $forderToRun = 'win32'
  }

  Set-Content -Path ($toolsPath + "\nssm-$nssmVersion\$folderToIgnore\nssm.exe.ignore") -Value $null
  $nssmBinPath = ($toolsPath + "\nssm-$nssmVersion\$forderToRun\nssm.exe")

  # Unzip and move Consul
  Get-ChocolateyUnzip  $sourcePath "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
  Get-ChocolateyUnzip  $sourcePathUI "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

  Write-Host "Creating $env:PROGRAMDATA\consul\logs"
  New-Item -ItemType directory -Path "$env:PROGRAMDATA\consul\logs" -ErrorAction SilentlyContinue | Out-Null
  Write-Host "Creating $env:PROGRAMDATA\consul\config"
  New-Item -ItemType directory -Path "$env:PROGRAMDATA\consul\config" -ErrorAction SilentlyContinue | Out-Null

  # Create event log source
  # User -Force to avoid "A key at this path already exists" exception. Overwrite not an issue since key is not further modified
  $registryPath = 'HKLM:\SYSTEM\CurrentControlSet\services\eventlog\Application'
  New-Item -Path $registryPath -Name consul -Force | Out-Null
  # Set EventMessageFile value
  Set-ItemProperty $registryPath\consul EventMessageFile "C:\Windows\Microsoft.NET\Framework64\v2.0.50727\EventLogMessages.dll" | Out-Null


  #Uninstall service if it already exists. Stops the service first if it's running
  $service = Get-Service "consul" -ErrorAction SilentlyContinue
  if ($service) {
    Write-Host "Uninstalling existing service"
    if ($service.Status -eq "Running") {
      Write-Host "Stopping consul process ..."
      net stop consul | Out-Null
    }

    $service = Get-WmiObject -Class Win32_Service -Filter "Name='consul'"
    $service.delete() | Out-Null
  }

  Write-Host "Installing the consul service"
  # Install the service
  & $nssmBinPath install consul $(Join-Path $toolsPath "consul.exe") agent -config-dir=%PROGRAMDATA%\consul\config -data-dir=%PROGRAMDATA%\consul\data | Out-Null
  & $nssmBinPath set consul AppEnvironmentExtra GOMAXPROCS=$env:NUMBER_OF_PROCESSORS | Out-Null
  & $nssmBinPath set consul ObjectName NetworkService | Out-Null
  & $nssmBinPath set consul AppStdout "$env:PROGRAMDATA\consul\logs\consul-output.log" | Out-Null
  & $nssmBinPath set consul AppStderr "$env:PROGRAMDATA\consul\logs\consul-error.log" | Out-Null



  Write-ChocolateySuccess 'consul'
} catch {
  Write-ChocolateyFailure 'consul' $($_.Exception.Message)
  throw
}
