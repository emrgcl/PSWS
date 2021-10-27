# Some Nice Samples to play with

## EventLog Samles


- Service Control Manager Errors in the last **$NumberOfDays**.

    ```PowerShell
    $NumberOfDays = 100
    $FilterHash = @{

        ProviderName = 'Service Control Manager'
        LogName = 'System'
        Starttime = (Get-Date).AddDays((-1*$NumberOfDays))
        LEvel = 2

    }

    Get-WinEvent -FilterHashtable $FilterHash
    ```

- Critical Windows Events from Scom Management Pack - there are small bugs for to find and fix :)

    ```PowerShell
    $EventTable = @{

        System = @{
        'Microsoft-Windows-WindowsUpdateClient' = @(20,19,18)
        'Server' = @(2507,2511,2506)
        'EventLog' = @(6005,6006,6008)
        'Microsoft-Windows-Eventlog' = @(6000)
        'TCPIP' = @(4198,4199,4202)
        'DISK' = @(31,11,50,41,55,4036)
        'Ntfs' = @(11,50,41,55,98)
        'Bugcheck' = @(1000,1001)
        'Service Control Manager' = @(7000,7001,7002,7003,,7015,7017,7018,7019,7020,7022,7023,7025,7026,7030,7032,7033,7034,7037,7038,7041)
        }
        Application = @{
        'Perflib'  = @(1015)
        'loadperf'  = @(2004,2006,2007,3000,3001,3002,30012,3015,3018)
        'Wininit'  = @(1001)
        }

    }

    $NumberOfDays = 100

    Foreach ($EventLog in $EventTable.Keys) {

    $LogName = $EventLog
    $EvenMetaData = $EventTable.$EventLog
    Foreach ($ProviderName in $EvenMetaData.Keys) {


    $FilterHashTable = @{

        ProviderName = $ProviderName
        LogName = $LogName
        ID = $EvenMetaData.$ProviderName
        Starttime = (Get-Date).AddDays((-1*$NumberOfDays))

    }

    Get-WinEvent -FilterHashtable $FilterHashTable -ErrorAction SilentlyContinue

    } 

    }

    ```