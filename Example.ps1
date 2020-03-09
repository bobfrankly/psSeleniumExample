# Load Helper Functions
. (Join-Path $PSScriptRoot .\helperFunctions.ps1)
# Match ChromeDriver to Installed Chrome Version
MatchChromeDriverToInstalledChrome

# Load your DLLS
$dotNetVersion = 45
$listOfDlls = if ($PSScriptRoot -eq ""){
    #Running outside of script
    Get-ChildItem -Path ./Selenium*/lib/net$dotNetVersion/*.dll
}else{
    #Running inside of script
    Get-ChildItem -Path $PSScriptRoot/Selenium*/lib/net$dotNetVersion/*.dll
}

foreach ($dll in $listOfDlls | Sort-Object Name){ #Sorting causes them to load in the correct order :)
    Add-Type -LiteralPath $dll.FullName
}

# End Loading of DLLS
###### 

$path = Get-ChildItem $PSScriptRoot -Recurse "chromedriver.exe" # Find the Chrome Driver EXE
$driver = New-Object -TypeName "OpenQA.Selenium.Chrome.ChromeDriver" -ArgumentList @($path.Directory) # Start a new instance

$driver.navigate().GoToUrl("https://www.lmgtfy.com") #This demands a full URL

# Find the elementS (plural) by class, grab the 5th one, click on it
($driver.FindElementsByClassName("glide__slide"))[4].click()
$driver.FindElementByClassName('gLFyf').SendKeys("Selenium")
$driver.f
$driver.FindElementsByName('btnI').click()
Start-Sleep -s 8
$driver.quit()
