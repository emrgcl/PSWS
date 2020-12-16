$PropertyHash=@{
    
    Name ='DaysToExpire'
    Expression = {
    
        $DaystoExpire = [Math]::Round(($_.NotAfter - (Get-date)).TotalDays,2)
        
        # aşağıda -lt 1', prod ortamında -eq 0 olarak değiştirin bir zahmet :)
        if ($DaystoExpire -lt 1) {
            
            'Expired'
        
        } else {
        
        $DaystoExpire
        
        }
    
    }

}

gci Cert:\LocalMachine\My | Select-Object -Property Thumbprint,Subject,$PropertyHash | Sort-Object -Property DaysToExpire

