$ServerInventory = @(

@{HostName = 'emreg-web01';ServicesToCheck = @('spooler','Alg');StartIfStopped = $true}
@{HostName = 'emreg-web02';ServicesToCheck = @('spooler');StartIfStopped = $False}


)
$Result=@()
Foreach ($Server in $ServerInventory) {

$Services = Get-Service -Name $Server['ServicesToCheck'] -ComputerName $Server['Hostname']
    Foreach ($Service in $services) {

    if ($Service.Status.ToString() -eq 'stopped' -and $Server['StartIfStopped'] -eq $true) {
    
    Write-Verbose "Starting $($SErvice.Name) service on $($Service.MachineName)"
    $Service | Start-Service
    
    }


    }
    $Services = Get-Service -Name $Server['ServicesToCheck'] -ComputerName $Server['Hostname']
    Foreach($Service in $Services){
    $Result+=$Service
    }
}
$Result | Format-Table -AutoSize -Property Name,DisplayName,Status,StartType,MachineName