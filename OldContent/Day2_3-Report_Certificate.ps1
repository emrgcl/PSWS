$HTMLHeader=@"
<style>

    table {
		font-size: 12px;
		border: 0px; 
		font-family: Arial, Helvetica, sans-serif;
	} 
	
    td {
		padding: 4px;
		margin: 0px;
		border: 0;
	}
	
    th {
        background: #395870;
        background: linear-gradient(#49708f, #293f50);
        color: #fff;
        font-size: 11px;
        text-transform: uppercase;
        padding: 10px 15px;
        vertical-align: middle;
	}

    tbody tr:nth-child(even) {
        background: #f0f0f2;
    }
</style>

"@

$DaysToExpire = @{
    
    Name='DaysToExpire'
    Expression={
        $Days = [math]::Round(($_.NotAfter - (Get-Date)).TotalDays,2)
        
        if ($Days -le 1) {
            
            'Expired'
        
        } else {
        
        $Days
        
        }
        
    
    }

}

$Result = gci Cert:\LocalMachine\My | Select-Object -Property Thumbprint,Subject,$DaysToExpire 
$Result | ConvertTo-Html -Title 'Certificate Report' -head $HTMLHeader  | Out-File -FilePath c:\temp\cert.html