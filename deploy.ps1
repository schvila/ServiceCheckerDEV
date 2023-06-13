#FIX c:\ in json prop to c:\\
$jsonAppSetFilePath = "#{KestrelDir}\#{Octopus.Step.Name}\appsettings.json"

$json = Get-Content -Raw -Path $jsonAppSetFilePath

# Replace the unescaped backslashes with escaped backslashes
$jsonFixed = $json -replace '(?<!\\)\\(?!\\)', '\\\\'

# Write the fixed JSON back out to the file
Set-Content -Path $jsonAppSetFilePath -Value $jsonFixed


