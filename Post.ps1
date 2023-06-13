function AddNewApp($newAppName, $newUrl) {
    # Load the XML file
    $path = "#{KestrelDir}\#{Octopus.Step.Name}\config.xml"
    $pathPrev = "#{KestrelDir}\#{Octopus.Step.Name}\config_prev.xml"
    $wPath = $path
    if (Test-Path $pathPrev) {
        $wPath = $pathPrev 
    }    
    Write-Host "config $path"
    [xml]$xml = Get-Content $wPath

    # Check if the app already exists
    $app1Name = "UpdateTransactions_" + $newAppName
    $app2Name = "LogoutInactivePlayers_" + $newAppName

    if (($xml.config.app | Where-Object { $_.name -eq $app1Name }) -or ($xml.config.app | Where-Object { $_.name -eq $app2Name })) {
        Write-Host "App '$app1Name' or '$app2Name' already exists."
        return
    }
	Write-Host "add $app1Name and $app2Name"
    # Create the first new app node
    $newApp1 = $xml.CreateElement("app")
    $newApp1.SetAttribute("name", $app1Name)
    $newApp1.SetAttribute("type", "url")
    $newApp1.SetAttribute("period", "2")
    $newApp1.SetAttribute("timerPeriod", "60000")
    $newApp1.SetAttribute("url", "https://" + $newUrl + "/G000/CommonService.svc/UpdateTransactions")
    $cdata1 = $xml.CreateCDataSection('{"password":"SRvce..4Tur126@pa"}')
    $newApp1.AppendChild($cdata1)

    # Create the second new app node
    $newApp2 = $xml.CreateElement("app")
    $newApp2.SetAttribute("name", $app2Name)
    $newApp2.SetAttribute("type", "url")
    $newApp2.SetAttribute("period", "2")
    $newApp2.SetAttribute("timerPeriod", "60000")
    $newApp2.SetAttribute("url", "https://" + $newUrl + "/G000/PlayerService.svc/LogoutInactivePlayers")
    $cdata2 = $xml.CreateCDataSection('{"password":"SRvce..4Tur126@pa"}')
    $newApp2.AppendChild($cdata2)

    # Append the new app nodes to the XML's config node
    $xml.DocumentElement.AppendChild($newApp1) | Out-Null
    $xml.DocumentElement.AppendChild($newApp2) | Out-Null    

    # Save the XML back to the file
    $xml.Save($path)
    $xml.Save($pathPrev)
}

AddNewApp -newAppName "#{Tenant.Alias}" -newUrl "#{Tenant.BaseUrl}"
