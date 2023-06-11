
function AddNewApp($newAppName, $newUrl) {
    # Load the XML file
    [xml]$xml = Get-Content 'C:\path\to\your\file.xml'

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
    $xml.config.AppendChild($newApp1) | Out-Null
    $xml.config.AppendChild($newApp2) | Out-Null

    # Save the XML back to the file
    $xml.Save('C:\path\to\your\file.xml')
}
