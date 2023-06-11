sc create OC.ServiceChecker binPath="c:\IIS\Application\OC.ServiceCheckerNet7\OC.ServiceChecker.exe" DisplayName= "OC.ServiceCheckerNet7" obj= "NT AUTHORITY\LocalService" start= delayed-auto

sc description OC.ServiceChecker "Periodicke volani services z config.xml (UpdateTransactions,LogoutInactivePlayers...)"
rem automaticky pridani restart sluzby po padu
sc failure OC.ServiceChecker reset= 0 actions= restart/60000/restart/60000/restart/60000//1000
rem enables actions for stops with errors 
  sc.exe failureflag "OC.ServiceChecker" 1  

sc start OC.ServiceChecker

