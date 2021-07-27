$UsersArray = 'emreg@microsoft.com','emreg2@microsoft.com','emreg3@microsoft.com','emreg4@microsoft.com','emreg6@microsoft.com'

$ObjectToWork = [PsCustomObject]@{

    Name = 'Onemli Object'
    Users = $UsersArray

}
$LastUseraddedHash = @{

Name = 'LastUserAdded'
Expression = {($_.Users)[-1]}

}
$ObjectToWork | Select-Object -Property Name,Users
$ObjectToWork | Select-Object -Property Name,$LastUseraddedHash