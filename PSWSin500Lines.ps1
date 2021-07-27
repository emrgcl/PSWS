# string, int, array, hashtable, pscustomboject, scriptblock, DateTime,TimeSpan, math
# greetings to Taylan!

#region PowerShellVErsion
$PSVersionTable

<#
Recommended Powershell: 5.1 => https://docs.microsoft.com/en-us/powershell/scripting/windows-powershell/wmf/setup/install-configure?view=powershell-7.1
Command Format: Verb-Noun
#>
#endregion

#region CmdLet Introduction - Discovering CMDlets
# lists all available commands
get-command 

# lists specified command
get-command -Verb get
Get-command -Noun service

# lists all commands in specified module
Get-Command -Module Microsoft.PowerShell.Management

# how to use a command?
get-command -Name get-service -Syntax

#endregion

#region Discovering Objects
# To get all properties on an object
Get-Service -Name 'spooler' | Format-List -Property *

# Show all members of an object
Get-Service -Name 'Spooler' | Get-Member

#endregion

#region Variables
$ServiceName = 'Spooler'

# değişkeni de get-membere gönderek ilgili ojbectin tipi ve özelliklerini görebiliriz.
$ServiceName | Get-Member

# objectnin özelliklerine erişmek veya bir methodu çalıştırmak
$ServiceName.Length
$ServiceName.Substring(0,2)

# değişkeni kullanalım
Get-Service -Name $ServiceName
#endregion

#region string object

# Literal String
$Age = 44
$Message = 'Emre $Age yaşındadır.'

# Expandable String
$Message = "Emre $Age yaşındadır."

# SubExpression - Asprin()
Stop-Service -InputObject (Get-Service -Name 'Spooler')

#Variable subexpression  - String içinde komut kullanma
$Service = Get-Service -Name 'Spooler'
$Message = "üzerinde çalışacağım serivisn adı: $Service.Name"
$Message
$Message = "üzerinde çalışacağım serivisn adı: $($Service.Name)"
$Message
$Message = "üzerinde çalışacağım serivisn adı: $((Get-Service -Name 'Spooler').Name)"
$Message
#endregion

#region Type Casting (weak/strong) = Tipini belirleme (zayıf / kuvvetli)

# Zayıf
$Message = [string]'olksjdflkjsdf'
$Message = 32

# Güçlü
[string]$Message = 'ilksıdjflsjdlfds'
[string]$Message = 32
#endregion

#region Hashtable

$ServerInfo = @{'OSName' = 'Windows Server 2016';'Memory' = 16}

$ServerInfo = @{

                  'OSName' = 'Windows Server 2016'
                  'Memory' = 16

}

# kelimenin anlamı
$ServerInfo.OSName
$ServerInfo['OSName']

$ServerInfo['CPU']=4
$ServerInfo.Add('Owner','Taylan')

# key / kelime kontrolü
$ServerInfo.Keys -contains 'CPU'

#endregion

#region PScustomOBject, Array, Arraylist


$ServerInfo = [PSCustomObject]@{

                  'OSName' = 'Windows Server 2016'
                  'Memory' = 16
                  'CPU' = 4
                  'Owner' = 'Levent'
                  'Hostname' = 'srv1'

}

$ServerInfo2 = [PSCustomObject]@{

                  'OSName' = 'Windows Server 2019'
                  'Memory' = 64
                  'CPU' = 8
                  'Owner' = 'Emre'
                  'Hostname' = 'srv2'
 
}


[System.Collections.ArrayList]$Servers = $ServerInfo,$ServerInfo2

$Servers | ? {$_.Owner -eq 'Emre'}


#endregion

#region string to array , array to string

$List='file1,file2,file3,file4,file5,file6,file7,file8'
$FileList = $List -split ','

Write-Output "The following files were edited. $FileList"

$StringFromArray=$FileList -join ','
Write-Output "The following files were edited. $StringFromArray"

#endregion

#region introduction to advanced functions

Function New-ServerInfo {

[CmdLetBinding()]
Param(
      [Parameter(Mandatory=$true)]
      [string]$OSName,
      [Parameter(Mandatory=$true)]
      [int32]$Memory,
      [Parameter(Mandatory=$true)]
      [int32]$CPU,
      [string[]]$Owners=@('Taylan'),
      [Parameter(Mandatory=$true)]
      [string]$Hostname
)

$ServerInfo = [PScustomObject]@{

                  'OSName' = $OSName
                  'Memory' = $Memory
                  'CPU' = $CPU
                  'Owner' = $Owners
                  'Hostname' = $Hostname
}

$ServerInfo

}

$Server1 = New-ServerInfo -OSName 'Windows 2019' -Memory 4 -CPU 8 -Owner 'Taylan' -Hostname Srv1
$Server2 = New-ServerInfo -OSName 'Windows 2012' -Memory 8 -CPU 8 -Owner 'Taylan' -Hostname Srv2
$Server3 = New-ServerInfo -Memory 8 -CPU 8 -Owner 'Taylan','Emre'
$Server5 = New-ServerInfo -OSName 'Windows 2016' -Memory 32 -CPU 8 -Hostname Srv5

#endregion

#region foreach loop
#endregion

#region Introduction to pipelines
#endregion

#region Static Members (Member = Property , Method

[math] | Get-Member -Static
[Math]::Round(23432.234234,2)

#endregion

#region Select-Object

gci Cert:\LocalMachine\My | Select-Object -Property Thumbprint,Subject,NotAfter

# custom field / özel kolon üretmek => özel hahstable => @{Name='';Expression={}}

gci Cert:\LocalMachine\My | Select-Object -Property Thumbprint,Subject,NotAfter,@{Name='DaysToExpire';Expression={$_.NotAfter}}


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
gci Cert:\LocalMachine\My | Select-Object -Property Thumbprint,Subject,$DaysToExpire


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

$Result = gci Cert:\LocalMachine\My | Select-Object -Property Thumbprint,Subject,$DaysToExpire 
$Result | ConvertTo-Html -Title 'Certificate Report' -head $HTMLHeader  | Out-File -FilePath c:\temp\cert.html

#endregion

#region Importing from disk

$ServersFromTxt = Get-Content C:\temp\servers.txt


Function ConvertTo-Int32 {

[CmdletBinding()]
Param(

[Parameter(ValueFromPipeLine=$true)]
[PSCustomObject]$InputObject

)

Process {

$ConvertedProperties = @{}
$Properties = ($_ | Get-Member -MemberType NoteProperty).Name
Foreach ($Property in $Properties) {

if ($_.$Property -as [int32]) {

$ConvertedProperties.Add($Property,($_.$Property -as [int32]))

} else {

$ConvertedProperties.Add($Property,($_.$Property))

}


}

[PsCustomObject]$ConvertedProperties

}


}

$Servers = Import-Csv -Path C:\temp\ServerList.csv | ConvertTo-Int32

#endregion

#region Advanced Functions - More

Function say-hello {

[CmdletBinding(

    PositionalBinding = $False

)]
Param(
    [ValidateNotNullOrEmpty()]
    [ValidateLength(3,30)]
    [Parameter(ParameterSetName='Name')]
    [string]$Name,
    [Parameter(ParameterSetName='FullName')]
    [string]$FullName,
    [Parameter(Mandatory=$true)]
    [ValidateRange(18,65)]
    [int32]$Age,
    [Parameter(Mandatory=$true)]
    [ValidateSet('Male','Female')]
    [string]$Gender
)

switch ($Gender)
{
'Male' {
            if($PSCmdlet.ParameterSetName -eq 'Name')
            {
            
                $Message = "Merhaba $Name. Yaşın da maşallah $Age olmuş."
            
            } else {
            
                $Message = "Merhaba Sayın $FullName. Yaşınız $Age ."
            
            } 
       }

'Female' {
            if($PSCmdlet.ParameterSetName -eq 'Name')
            {
            
                $Message = "Merhaba $Name."
            
            } else {
            
                $Message = "Merhaba Sayın $FullName."
            
            }             
            
}

}

Write-output -InputObject $Message

}

Say-hello -Name 'Emre' -Age 44 -Gender 'Male'
Say-hello -Name 'nihal' -Age 28 -Gender 'Female'


Function Delete-Email {

[CmdletBinding(

    SupportsShouldProcess = $true

)]
Param(
    
    [Parameter(Mandatory=$true,ValueFromPipeLine=$true)]
    [string[]]$Email

)
Process {

        if ($pscmdlet.ShouldProcess($email, "deleting email"))
        {
            Write-Output "Deleted $Email"
        }


}
}




Delete-Email -Email 'emreg@microsoft.com'

#endregion

#region creating modules
New-ModuleManifest -Path C:\temp\Modules\TDUtility\TDUtility.psd1

#endregion

#region error handling - Basic

# hatalar $error arrayine gider
Get-Service -Name hedehodo -ErrorAction SilentlyContinue

if(-not $?) {

"an error occured: Message = $($Error[0].Exception.Message)"


}



#endregion

#region error handling -try catch finally

$WEbclient = new-object -TypeName System.Net.WebClient
$ErrorCount = 0
try {

Get-Service -Name Spooler -ErrorAction Stop # default erroaction continue
#$WEbclient.DownloadFile('https://github.com/emrgcl/PSWS/blob/main/Operation1.csv','c:\temp\download\Operation.csv') # erroction stop

}

catch {
++$ErrorCount
"An Error occured. $($Error[0].Exception.Message)."

}

finally {

if ($ErrorCount -eq 0) {
'Operation completed Successfully.'

} else {

"Operation completed with errors. Number of errors occured: $ErrorCount."
} 

'Removing httpclient.'
$WEbclient.Dispose()

}


#endregion

#region remoting


$Servers = 'emreg-web01','emreg-web02','emreg-web03'

# Legacy remoting

Get-Service -Name ALG,Spooler -ComputerName $Servers # RPC TCP 135, 1024

# list commands supporting computername parameter
Get-Command -ParameterName ComputerName

# Advanced Remoting - PSSession WSMaN (http 5985, httpssl 5986) - enabled on all servers using Enable-psremoting

$scriptBlock = {Get-Service -Name Alg,Spooler}

$SleepScript = {1..50 | % {'.';Start-Sleep -Seconds 1}}

# 1. Temporary Session (100'e kullan)
Invoke-Command -ComputerName $Servers -ScriptBlock $scriptBlock

# 2. Persistent Session (1000 sunucu için daha mantıklıklı)
$session = New-PSSession -ComputerName $Servers
Invoke-command -Session $session[1] -ScriptBlock $SleepScript -AsJob
Invoke-Command -Session $session -ScriptBlock $scriptBlock
Remove-PSSession -Session $session

#endregion

