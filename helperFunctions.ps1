$chromeDriverRoot = (Join-Path $PSScriptRoot "chromeDriver")
function MatchChromeDriverToInstalledChrome{
    # Set Folder Path
    $chromeDriverRoot = (Join-Path $PSScriptRoot "chromeDriver")

    # Find Installed Chrome.exe via Registry
    $chromePath = (Get-ItemProperty "HKLM:\\Software\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe").'(default)'
    # Get Installed Version from the Chrome Executable, Select only the first 3 pieces of the number as per the API does
    (Get-Item $chromePath).VersionInfo.productVersion -match "\d+.\d+.\d+"
    
    # Request the Matching ChromeDriver Version from the API
    $chromedriverURI = "https://chromedriver.storage.googleapis.com/LATEST_RELEASE_" + $Matches[0]
    Write-Host -ForegroundColor "Yellow" "Matching ChromeDriver version with Installed Chrome via $chromeDriverURI"
    $ChromeDriverDLVersion = (Invoke-WebRequest -uri $chromedriverURI).content
    
    # Create the ChromeDriver folder if it doesn't already exist
    if (!(Test-Path (Join-Path $PSScriptRoot 'chromeDriver'))){
        New-Item -Path $PSScriptRoot -Name "chromeDriver" -ItemType Directory
    }

    # Check to see if this ChromeDriver Version is ready, clean out non-matching versions if it's not and grab the matching version
    if (!(Test-Path (Join-Path $chromeDriverRoot "\$ChromeDriverDLVersion\chromedriver.exe"))){
        # Matching ChromeDriver is not there, time to work!
        # Remove other non-matching Chrome Drivers
        Get-ChildItem $chromeDriverRoot -Recurse | Sort-Object FullName -Descending | Remove-Item -Force
        # Download the Matching ChromeDriver zip
        $chromeDriverDLURI = ("https://chromedriver.storage.googleapis.com/" + $ChromeDriverDLVersion + "/chromedriver_win32.zip")
        Write-Host -ForegroundColor "Yellow" "Grabbing matching ChromeDriver zip from $chromeDriverDLURI"
        Invoke-WebRequest -uri $chromeDriverDLURI  -OutFile (Join-Path $PSScriptRoot 'chromedriver/chromedriver.zip')
        # Unzip the Matching ChromeDriver EXE into the version named path
        Expand-Archive -Path (Join-Path $PSScriptRoot 'chromedriver/chromedriver.zip') -DestinationPath (Join-Path $PSScriptRoot "chromedriver/$ChromeDriverDLVersion")
    }else{
        # Mathing ChromeDriver already exists, nothing to do
        Write-Host -ForegroundColor "Yellow" "ChromeDriver version matches installed Chrome."
    }
}
