$serviceName = "OC.ServiceChecker"

$service = Get-Service $serviceName -ErrorAction SilentlyContinue

$name = sc.exe GetKeyName $serviceName
Write-Host "Name: $name"

if($service) {
    Write-Host "Stopping the $serviceName service"
    Stop-Service $serviceName -Force
    $service.WaitForStatus('Stopped', '00:00:30')
    if ($service.Status -ne 'Stopped') {
        Write-Warning "Service $serviceName did not stop within 30 seconds"
    } else {
        Write-Host "Service $serviceName stopped"
        #tart-Sleep -Seconds 10  # Add a delay
        #Remove-Service -Name $serviceName
        sc.exe delete $serviceName
    }

}