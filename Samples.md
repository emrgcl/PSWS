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