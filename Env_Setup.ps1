# Establish where Nuget is
$nuget = Join-Path $PSScriptRoot "nuget\nuget.exe"
# Look for any further packages you need at https://www.nuget.org/packages?q=selenium and add them with C:\Temp\nuget.exe install <name>
write-output $nuget 
if (!(Test-Path $nuget)){
    New-Item -Path $PSScriptRoot -Name "Nuget" -ItemType Directory
    Write-Verbose "Downloading Nuget.exe to $nuget"
    Invoke-WebRequest https://dist.nuget.org/win-x86-commandline/latest/nuget.exe -OutFile $nuget
}

# Grab Selenium Libraries
[array]$list = "install Selenium.WebDriver" # Primary WebDriver
 $list += "install Selenium.Support"  # Primary Webdriver Support
 $list += "install Selenium.WebDriverBackedSelenium"

foreach ($cmd in $list){
    Start-Process $PSScriptRoot\nuget\nuget.exe -ArgumentList $cmd -Wait
}

# Chrome Driver Handling
. (Join-Path $PSScriptRoot .\helperFunctions.ps1)
# Match ChromeDriver to Installed Chrome Version
MatchChromeDriverToInstalledChrome
