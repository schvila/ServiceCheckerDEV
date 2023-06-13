$serviceName = "OC.ServiceChecker"
Write-Host "PreDeploy uninstall $serviceName service."
try {
    $service = Get-Service $serviceName -ErrorAction SilentlyContinue
    if ($service) {
        Write-Host "unistalling existing the $serviceName service"
        # Stop the service
        Stop-Service $serviceName -Force

        # Wait until the service has stopped or for 30 seconds
        $service.WaitForStatus('Stopped', '00:00:30')

        # Delete the service
        sc.exe delete $serviceName    
    }
    else {
        Write-Host "Service not found $serviceName"
    }   
}
catch {
    Write-Host "Uninstall Error: $_"
    #exit 1
}
