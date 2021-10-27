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

- Critical Windows Events from Scom Management Pack

    ```PowerShell
    $CriticalSources='Microsoft-Windows-WindowsUpdateClient','Server','Wininit','EventLog','Microsoft-Windows-Eventlog','TCPIP','DISK','Ntfs','Perflib','loadperf','Bugcheck','Service Control Manager'
    $Logs = 'System','Application'
    $IDS = @(1001,6006,6008,6000,6005,4198,4199,31,4202,11,50,41,55,40,36,1015,2004,2006,1000,7030,7037,7015,7017,70,18,7019)
    $FilterHash = @{

    LogName = $Logs
    ProviderName = $CriticalSources
    ID = $IDs

    }
    Get-WinEvent -FilterHashtable $FilterHash -ErrorAction SilentlyContinue
    ```