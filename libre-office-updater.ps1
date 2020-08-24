param(
	[string] $v = "-",
	[int] $win = 0,
	[switch] $i = $false,
	[switch] $d = $false
)

$author = 'lrusso96'
$name = 'Libre Office Updater Tool'
$year = '2020'
$license = 'GPL'
$version = '0.1.0'

function Print-Info(){
	Write-Host "Welcome to " -NoNewLine
	Write-Host "$name " -ForegroundColor Green -NoNewLine
	Write-Host "v$version ($year)."
	Write-Host "This script has been developed by $author and is distributed under $license license."
}

function Print-Config(){
	Write-Host "`nLibre Office Version: " -ForegroundColor Yellow -NoNewLine
	Write-Host "$v"
	Write-Host "Windows Version: " -ForegroundColor Yellow -NoNewLine
	Write-Host "$win bit"
	Write-Host 'Skip Download Dialog: ' -ForegroundColor Yellow -NoNewLine
	Write-Host "$d"
	Write-Host 'Skip Installation Dialog: ' -ForegroundColor Yellow -NoNewLine
	Write-Host "$i"
}

function Welcome(){
	Print-Info

	If ($script:v -eq '-'){
		Write-Host "`nInsert Libre Office Version (e.g. 7.0.0): " -ForegroundColor Yellow -NoNewline
		$script:v = Read-Host
	}

	If ($script:win -eq 0){
		Write-Host "`nInsert Windows Version (32 | 64 [default]): " -ForegroundColor Yellow -NoNewline
		$win = Read-Host
		Switch ($win) {
			32 {$script:win=32}
			Default {$script:win=64}
		}
	}

	Clear-Host
	Print-Info
	Print-Config
}

Welcome

If (-Not $d){
	Write-Host "`nWould you like to proceed? (Y/N): " -ForegroundColor Yellow -NoNewline
	$Readhost = Read-Host
	Switch ($ReadHost) {
		N {$shouldDownload=$false}
		Default {$shouldDownload=$true}
	}

	If (-Not $shouldDownload) {
		Write-Host "`nNevermind. See you!"
		exit
	}
}

Clear-Host
$arch = 'x86'
If ($win -eq 64){
	$fullArch = 'x86_64'
	$arch = 'x64'
}
ElseIf ($win -eq 32){
	$fullArch = 'x86'
	$arch = $fullArch
}
Invoke-WebRequest "https://download.documentfoundation.org/libreoffice/stable/$v/win/$fullArch/LibreOffice_$($v)_Win_$arch.msi" -O libre_office_installer.msi
Print-Info
Print-Config

If (-Not $i){
	Write-Host "`nWould you like to install Libre Office now? (Y/N): " -ForegroundColor Yellow -NoNewline
	$Readhost = Read-Host
	Switch ($ReadHost) {
		N {$shouldInstall=$false}
		Default {$shouldInstall=$true}
	}
}

If ($i -or $shouldInstall) {
	msiexec /i 'libre_office_installer.msi'
}
