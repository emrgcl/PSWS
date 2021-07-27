Function Invoke-ServerOperation {
    
    [CmdletBinding()]
    Param(
    
        [Parameter(ValueFromPipelineByPropertyName = $true,ValueFromPipeline=$true)]
        [string[]]$Server
    
    )
    

Begin {

Write-Verbose 'Function Started'

}

Process {

Foreach ($Srv in $Server) {

"Executing operation super critical on $Srv"

}

}


End {

Write-Verbose 'Function Ended'
}
}


Invoke-ServerOperation -Server 'server1'
Import-Csv -Path C:\repos\psws\Operation.csv | Invoke-ServerOperation
get-content -Path C:\repos\PSWS\Opereation.txt | Invoke-ServerOperation -Verbose
'server1','Server2','Server3' | Invoke-ServerOperation
Invoke-ServerOperation -Server 'server1','Server2','Server3'