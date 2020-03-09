# Selenium Example #
- Run the Env_Setup.PS1 to setup your environment. This will download nuget, and use nuget to grab the current versions of the nuget libraries.
- Open and run the Example.ps1 to launch the Chrome Driver and attempt to do a LMGTFY.com automation. It'll work provided the site hasn't changed too much.

Selenium is a browser automation framework. The advantage of using Selenium is that once code has been written, it can be aimed at another browser without a total re-write. Chrome and Internet Explorer are supported, as are "GUI-less" clients like phantomJS. [The API is available here](https://seleniumhq.github.io/selenium/docs/api/dotnet/), and the currently available browsers are commonly listed near the bottom.

Selenium is available in a few different languages, this example uses Powershell to consume the dotNet libraries. Nuget is used to retrieve the current dotnet libraries. 
