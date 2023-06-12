function AddNewApp($newAppName, $newUrl) {
    # Load the XML file
    $path = 'C:\_git\ServiceCheckerDEV\config.xml'
    $pathPrev = 'C:\_git\ServiceCheckerDEV\config_prev.xml'
    if (Test-Path $jsonAppSetPrevPath) {
        # Use the existing file path
        $workPath = $pathPrev
    }
    else {
        # Use the fallback file path
        $workPath = $path
    }

    [xml]$xml = Get-Content $workPath

    # Create the first new app node
    $newApp1 = $xml.CreateElement("app")
    $newApp1.SetAttribute("name", "UpdateTransactions_" + $newAppName)
    $newApp1.SetAttribute("type", "url")
    $newApp1.SetAttribute("period", "2")
    $newApp1.SetAttribute("timerPeriod", "60000")
    $newApp1.SetAttribute("url", "https://" + $newUrl + "/G000/CommonService.svc/UpdateTransactions")
    $cdata1 = $xml.CreateCDataSection('{"password":"SRvce..4Tur126@pa"}')
    $newApp1.AppendChild($cdata1)

    # Create the second new app node
    $newApp2 = $xml.CreateElement("app")
    $newApp2.SetAttribute("name", "LogoutInactivePlayers_" + $newAppName)
    $newApp2.SetAttribute("type", "url")
    $newApp2.SetAttribute("period", "2")
    $newApp2.SetAttribute("timerPeriod", "60000")
    $newApp2.SetAttribute("url", "https://" + $newUrl + "/G000/PlayerService.svc/LogoutInactivePlayers")
    $cdata2 = $xml.CreateCDataSection('{"password":"SRvce..4Tur126@pa"}')
    $newApp2.AppendChild($cdata2)

    # Append the new app nodes to the XML's config node
    # $xml.config.AppendChild($newApp1) | Out-Null
    # $xml.config.AppendChild($newApp2) | Out-Null
    $xml.DocumentElement.AppendChild($newApp1) | Out-Null
    $xml.DocumentElement.AppendChild($newApp2) | Out-Null    

    # Save the XML back to the file
    $xml.Save($pathPrev)
    $xml.Save($path)
}

AddNewApp -newAppName "Leris_Stage" -newUrl "stageleris.adell-trading.cz"
# AddNewApp -newAppName "Luckybet_Stage" -newUrl "stageluckybet.adell-trading.cz" 