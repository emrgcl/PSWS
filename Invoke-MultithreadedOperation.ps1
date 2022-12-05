Function new-OuNames {
    [CmdletBinding()]
    Param($NumberOfOus)
    
        $OuArray = @()
        1..$NumberOfOus | ForEach-Object -proces {$OuArray += "OU$($_)"}
        $OuArray
    
}
$ScriptToRun = {
    Param($OuString)
    
    $SleepSeconds= Get-Random -Minimum 1 -Maximum 5
    Start-Sleep $SleepSeconds
    [PsCustomObject]@{
        ThreadID = [appdomain]::GetCurrentThreadId()
        SleepSeconds = $SleepSeconds
        Ou = $OuString
    }
    
}
$ThreadCount = 100
$ScriptStart = Get-Date
$SessionState = [System.Management.Automation.Runspaces.InitialSessionState]::CreateDefault()
$RunspacePool = [runspacefactory]::CreateRunspacePool(1, $ThreadCount)
$RunspacePool.Open()
$Jobs = [System.Collections.ArrayList]::new()
$OUs = new-OuNames -NumberOfOus 30

#region create threads and beging Invoke
$PrepStart = Get-date
Foreach ($Ou in $Ous ) {

$PowerShell = [powershell]::Create($SessionState)
$PowerShell.RunspacePool = $RunspacePool
$Powershell.AddScript($ScriptToRun) | Out-Null
$PowerShell.AddParameters(@{OuString =$Ou}) | Out-Null
$JobObject = [PsCustomObject]@{
        Runspace = $PowerShell.BeginInvoke()
        Powershell = $PowerShell
}
$Jobs.Add($JobObject) | Out-Null


}

#endregion
#region wait job execution finish
while ($Jobs.Runspace.Iscompleted -contains $false) {
    $PercentProgress = [math]::Round(($Jobs.Runspace.IsCompleted | where-object {$_ -eq $true}).Count / $Jobs.Runspace.IsCompleted.Count * 100)
    Write-Progress -activity "Collecting OU Acls" -PercentComplete $PercentProgress -Status $PercentProgress
}
$Result = foreach ($Job in $Jobs) {
    $Job.Powershell.EndInvoke($Job.Runspace)
}
$ThreadTotalRunDuration =($Result.SleepSeconds | Measure-Object -Sum).Sum
$Result

$ScriptDuration = [Math]::Round(((Get-Date) - $ScriptStart).TotalSeconds)

Write-Host -ForegroundColor Cyan "Script ended in $ScriptDuration seconds."
Write-Host -ForegroundColor Blue "Threads spend total time: $ThreadTotalRunDuration seconds."
