﻿$ErrorActionPreference  = 'Stop';

$toolsDir               = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url                    = 'https://cdn.stardock.us/downloads/public/software/multiplicity/Multiplicity3_setup_sd.exe'
$checksum               = '82bd35e7e69f74da497e4b0fa7f73d4b7089f7c6f9deb994c798dc01b0a78d54'
$checksumType           = 'sha256'

$packageArgs = @{
  packageName           = $env:ChocolateyPackageName
  unzipLocation         = $toolsDir
  fileType              = 'exe'
  softwareName          = "Stardock Multiplicity*"
  url                   = $url
  checksum              = $checksum
  checksumType          = $checksumType
  silentArgs            = '/s'
  validExitCodes        = @(0)
}

[version]$OSVer = (Get-WmiObject Win32_OperatingSystem).Version
$min='6.1.7601'

If ( $OSVer -lt [version]$min ) {
  Write-Warning "*** Stardock Multiplicity requires an OS running Windows 7 or higher... ***`n"
  throw
} Else {
  Install-ChocolateyPackage @packageArgs
}
