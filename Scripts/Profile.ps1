function Prompt {

    $History = Get-History
    if ($null -ne $History) { 
  
    $executionTime = [math]::Round($(((Get-History)[-1].EndExecutionTime - (Get-History)[-1].StartExecutionTime).Totalmilliseconds),2)
    
    $Time = switch ($executionTime)
    {
        {$_ -ge 1000 -and $_ -lt 60000} {"$([math]::Round($(((Get-History)[-1].EndExecutionTime - (Get-History)[-1].StartExecutionTime).TotalSeconds),2)) sec"}
        {$_ -ge 60000 -and $_ -lt 3600000} {"$([math]::Round($(((Get-History)[-1].EndExecutionTime - (Get-History)[-1].StartExecutionTime).TotalMinutes),2)) mi"}
        {$_ -ge 3600000} {"$([math]::Round($(((Get-History)[-1].EndExecutionTime - (Get-History)[-1].StartExecutionTime).TotalHours),2)) hr"}
        Default {"$executionTime ms"}
    }
    
    $promptString = "[$time] $(Get-Location)>"
    } else {
    
    $promptString = "PS $(Get-Location)>"
    
    }
    Write-Host $promptString -NoNewline
    return " "
  } 
  