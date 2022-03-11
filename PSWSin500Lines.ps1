
# We are going to learn: String, int32, Array, Hasthable, PscustomOBject, Math, Datetime, ScriptBlock, Boolean(bool), TimeSpan
# .net = > FCL - Framework Class Library + CLI (.net runtime)

#region PowerShellVersion
<# 
1) Bill Gates, 
2) Mark Russinovich (NT Kernel, troubleshooing - Vice President of Azure, Windows Internals 1-2, Sysinternal (Procmon, psexec)
3) Jeffrey Snover - Entprise ARchitect of Powershell (Inventor)
2005: Powerhell invented - monad (Powershell v1) (Object Based (Windows .Net) + Clean Code Princples + Terminal)
2008: windows .net out of box with Windows Server and Clients (windows 2008, windows 7 - Powershell v2) ( the it focusing on virutalization: migrating from physical machines to vms)
2012: Critical year - Mature Azure / Cloud Services released (Powershell v3 - windows 2012 - windows .net oob, 2012r2 -v4)
2014: Satya Nadella became CEO - Microsoft Loves Open Source / Linux (Migrating from VMS => Continairs (Virtual OS) )
2016: .Net Core released - Cross platform works on windows, linux etc(Windows 10, Windows Server 2016i windows.net, powershell 5.1)
2018: Powershell 6 - .Net Core
2020: Powershell 7 - were as promised .net core based, you can call windows powrshell modules


#>
$PSVersionTable

# if you need to upgrade powershell - https://www.microsoft.com/en-us/download/details.aspx?id=54616 (5.1
# Powershell 7.2 is already a seperate indstallation: https://github.com/PowerShell/powershell/releases

#endregion

#region Discovering Cmdlet Introduction

# syntax of command names  - verb-noun structure
Get-Command

# to get a specic command
get-command -Noun 'Service'

# how to run the command
Get-command -Name 'Get-Service' -Syntax

Get-Service -Name 'Spooler','ALg' -ComputerName 'emreg-web01','emreg-web02'

#how to get commands in a specific module
Get-Command -Module 'Microsoft.PowerShell.Management'

#endregion

#region discovering objects - Part 1
get-Service -name 'Spooler'

Get-Service -Name 'spooler' | Format-List -Property *

#endregion

#region Discovering Objects - Part 2

Get-Service -Name 'Spooler' | Get-Member


#endregion

#region Variables - always always includes object(s)
$ServiceName = 'Spooler' 
$ServiceName | Get-Member
$ServiceName.Length
$ServiceName.Substring(0,3)

$SMSMessage = 'Thomas old old thomas Thomas old old thomas the wolf dragon the guru  old old thomas the wolf dragon the guru  old old thomas the wolf dragon the guru old old thomas the wolf dragon the guru  old old thomas the wolf dragon the guru old old thomas the wolf dragon the guru  old old thomas the wolf dragon the guru  old old thomas the wolf dragon the guru  old old thomas the wolf dragon the guru'
$SMSMessage.Length
$Result = $SMSMessage.Substring(1,160)
$Result.Length

Get-Command -Name 'Get-Service' -Syntax

Get-Service -Name $ServiceName


#endregion

#region Working with string objects 

#Literal Strings - ''

$Age = 45
$Message = 'Emre is $Age years old.'
$Message

$Message = 'Emre is ' + $Age + ' years old.'
$Message



#Expandable Strings - ""
$Age = 45
$Message = "Emre is $Age years old."
$Message

'I need $dollars more.'

# Escape character - `
<#

Escpae Character Workflow  turns
1. Stop your primary job
2. start your secondary job

#>

$Name = 'Thomas'
"I need `$dollars more from you $Name."

$SMSMessage =  "Dear $Name``s,`n I hope you find this sms useful.`n The info is nothing:P"
$SMSMessage


# SubExpression - Asprin - () - Temporay Variable

$Message = 'I love Powershell'
$Message.Length

('I Love Powershell').Length
(Get-Service -Name Spooler).DisplayName

# variable subexpression - $()

"There are $((('I Love Powershell').Substring(0,3)).Length)"

#endregion

#region Powershell - Help
# Cmdlet Help - Man pages- documentation of the commands

Get-Help -Name 'Get-Service'-ShowWindow
 
# conceptual help - About_ - How To
get-help -name about_sp*
Get-Help -Name about_Special_Characters -ShowWindow

#endregion

#region Type Casting

# Strong Type casting
[string]$Message = 'Sth stupid'
[string]$Message = 32

# Weak Type Casting
$Message = [string]32

$Number = [int32]'32' + 5
$Number



#endregion

#region ScriptBlock - code block - Nameless Function

$ScriptBlock = {get-service -Name 'spooler'}
$ScriptBlock | gm
$ScriptBlock.Invoke()

#endregion

#region hashtables - dictionary - Key and Value pairs 

$ServerInfo = @{

    OSName = 'Windows 10'
    NumberofCPU = 16
    OWner = 'Emre'

}

#getting info from hashtable
$ServerInfo['OsName']
$ServerInfo.OSName

$ServerInfo | Get-Member
$ServerInfo.Add('MemoryGB',64)
$ServerInfo.Add('Hostname','server1')


$ServerInfo

#Keys and Value

#endregion 

#region - Working with wmi


Get-WmiObject -Class win32_operatingsystem | Get-Member

$ServerInfo = @{
    
    OSName = (Get-WmiObject -Class Win32_operatingsystem).Caption
    MemoryGB = (Get-WmiObject -Class Win32_operatingsystem).TotalVisibleMemorysize * 1024 / 1gb
    NumberOfProcessors = [int32](Get-WmiObject -Class Win32_computersystem).NumberOfLogicalProcessors
    OWner = (Get-WmiObject -Class Win32_computersystem).PrimaryOwnerName

}
$ServerInfo

$ServerInfo.ContainsKey('OSname')
$ServerInfo.ContainsValue(32)
$ServerInfo.NumberOfProcessors | gm



$SomeHasthable = @{Name = 'Emre';SurName='Guclu';email='emreg@microsoft.com'}

#endregion

#region creating your own objects 

Get-Service -Name 'spooler', 'alg' | Export-Csv -Path c:\temp\services.csv -NoTypeInformation

$ServerInfo | Export-Csv -Path C:\temp\serverinfo.csv

$ServerInfoOBj = [Pscustomobject]@{
    
    OSName = (Get-WmiObject -Class Win32_operatingsystem).Caption
    MemoryGB = (Get-WmiObject -Class Win32_operatingsystem).TotalVisibleMemorysize * 1024 / 1gb
    NumberOfProcessors = [int32](Get-WmiObject -Class Win32_computersystem).NumberOfLogicalProcessors
    OWner = (Get-WmiObject -Class Win32_computersystem).PrimaryOwnerName

}

$ServerInfoOBj | export-csv -Path C:\temp\serverinfoobj.csv

#endregion 

#region Arrays and ArrayLists

$MyArray = @('Alberto Martinez','Jorge','Bruno',345)
Get-Member -InputObject $MyArray
# the number of elements/objects/items in the array
$MyArray.Count

# the first element in the array (by default - 0)
$MyArray[0]

# the last element in the array (by default - -1)
$MyArray[-1]

# range operator - int..int - get first 2 elements
$MyArray[0..1]

# getting index of an object
$MyArray.IndexOf(345)

#adding objects to basic array
$MyArray.Add('Miriam') # wont work for Basic Array (system.array)
$MyArray = $MyArray + 'Miriam' 
$MyArray += 'Miriam'

#adding objects to a more advanced array - System.Collections.ARraylist
$MyArrayList = [System.Collections.ArrayList]@('Alberto Martinez','Jorge','Bruno',345)
$MyArrayList.Add('Miriam')

#controling if an object exists in array , 'by default operators' = > Case insensitive
$MyArrayList -contains 'miriam'

# case sensitive contains
$MyArrayList -ccontains 'miriam'


#endregion 

#region don't return objects using [void] or out-bull

[void]$MyArrayList.Add('Carlos')
$MyArrayList.Add('Kamran') | Out-Null

#endregion

#region looping in arrays with Foreach

$SErverInfo1 = [PscustomObject]@{

    Hostname = 'Server1'
    CPU = 16
    MemmoryGB = 64
    OSName = 'Windows 2016'
    Owner = 'Carlos'

}
$SErverInfo2 = [PscustomObject]@{

    Hostname = 'Server2'
    CPU = 8
    MemmoryGB = 16
    Owner = 'Thomas'

}

$SErverInfo3 = [PscustomObject]@{

    Hostname = 'Server3'
    CPU = 32
    MemmoryGB = 128
    Owner = 'Miriam'

}

$Servers = [System.Collections.ArrayList]@($SErverInfo1,$SErverInfo2,$SErverInfo3)

# Looping with Foreach

Foreach ($Server in $Servers) {



    if ($Server.Owner -eq 'Thomas') {

    "Working on $($Server.Hostname)"

    }


}


#endregion

#region looping in Arays with Pipeline! - |

#Filtering in Pipeline
$Servers | Where-Object -FilterScript {$_.Owner -eq 'Thomas'}
$Servers | Where {$_.owner -eq 'Thomas'}
$Servers | ? {$_.owner -eq 'Thomas'}

#Do Operations in Pipeline
$Servers | Where-Object -FilterScript {$_.Owner -eq 'Thomas'} | ForEach-Object -Process { "Working on $($_.Hostname)"}

# bad way of preparations
$Servers | ForEach-Object -Process { 
'Importing some module' # operations required before the main operaiton
"Working on $($_.Hostname)"
'Processing finished' # operation required after the main operation
}
# use begin and end blocks for operations
$Servers | ForEach-Object -Begin {'Importing some module'} -Process { "Working on $($_.Hostname)"} -End {'Processing finished'}

Get-Service -Name 'Spooler' | Stop-Service

$CustomStupidObject = [PscustomObject]@{

    Name = 'spooler'
    Owner = 'Thomas'

}

$CustomStupidObject | Stop-Service

Get-Command -Name Stop-Service -Syntax

# go through each parameter and see th pipeline options
get-help Stop-Service -ShowWindow

#endregion

#region String to array , array to string

# string to array with -split operator -lets get the last element in below string
$List = 'file1,file2,file3,file4,file5'

# lets split and create an array
$FileListArray = $List -split ','
$LastFile = $FileListArray[-1]

# same with 1-liner approach
($List -split ',')[-1]

$FileListarray = @('file1 file2','file3','file4','file5')
$FileListString = $FileListArray -join ','
"Working on files: $FileListString"


#endregion

#region introduction advanced Functions
# legacy functions
Function do-sthbasic ($Name) {

"Hello $Name"

}

do-sthbasic -Name 'Kamran'

# ADvanced Function
Function new-serverinfo {

[CmdletBinding()]
Param(
    [Parameter(Mandatory=$true)]
    [string]$Osname,
    [Parameter(Mandatory=$true)]
    [int32]$memoryGB,
    [string]$Owner,
    [Parameter(Mandatory=$true)]
    [string]$Hostname
)

[Pscustomobject]@{

    Osname = $Osname
    MemoryGB = $memoryGB
    Owner = $Owner
    Hostname = $Hostname

}


}

$Server1 = New-ServerInfo -OSName 'Windows 2019' -MemoryGB 4 -Owner 'Walter' -Hostname 'Server1'
New-ServerInfo -OSName 'Windows 2019' -MemoryGB 4  -Hostname 'server3'

# use get-verb to name your functions Verb portion

#endregion

#region Switch Parameter

Function Get-InternetInformation {

[CmdletBinding()]
Param(
    [Parameter(Mandatory=$true)]
    [string]$URL,
    [switch]$EnableDirectAcces

)
if ($EnableDirectAcces.IsPresent) {

"accessing $URL over firewall"

} else {

"accessing $url over proxy"

}


}

Get-InternetInformation -URL 'http:/blabla.com/blabla' -EnableDirectAcces

#endregion

#region static members
$ServiceObject = Get-Service -Name 'Spooler' 
# get-member on the object dont show static members
$ServiceObject | Get-Member
$ServiceObject.Name

# use the following to see the static members
[math] | Get-Member -Static
[math]::PI
[math]::Round(3.14159265358979,2)
[math]::Round(3.14159265358979)

[string] | Get-Member -Static

$STring = $null

if ($STring -eq '' -or $String -eq $null) {

'string is empty or null'

}

if([string]::IsNullOrEmpty($String)) {

'string is empty or null'

}

[Pscustomobject]@{
    
    OSName = (Get-WmiObject -Class Win32_operatingsystem).Caption
    MemoryGB = [Math]::Round((Get-WmiObject -Class Win32_operatingsystem).TotalVisibleMemorysize * 1024 / 1gb)
    NumberOfProcessors = [int32](Get-WmiObject -Class Win32_computersystem).NumberOfLogicalProcessors
    OWner = (Get-WmiObject -Class Win32_computersystem).PrimaryOwnerName

}

#endregion

#region Providers & Report certificate expirations
# List of existing drives of providers
Get-PSDrive

# to access drive use what you already know : )
cd c:\
Set-Location c:\
Set-Location -Path c:\
Set-Location Cert:

dir
gci
Get-ChildItem

Set-Location -Path Cert:\LocalMachine\My
dir

#endregion

#region select-object

# format table only formats the object for only console..
gci Cert:\LocalMachine\My | Format-Table -Property Thumbprint,NotAfter | Export-Csv C:\Temp\table.csv

# use selecet-object to cut the properties and form a new object with the properties you desire
gci Cert:\LocalMachine\My | Select-Object -Property Thumbprint,NotAfter | Export-Csv C:\Temp\selectresult.csv


$DaysToExpire = @{

Name = 'DaysToExpire'
Expression = {
    
    $NumberOFDays = [Math]::Round(($_.NotAfter - (Get-Date)).TotalDays,2)
    # !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    # !!!! For the sake of demonstration the below threshold is 1 please change it to -le 0 in production. !!!!
    # !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    if ($NumberOFDays -le 1) {
    

    'Expired'

    
    } else {
        $NumberOFDays
    }

}

}
gci Cert:\LocalMachine\My | Select-Object -Property Thumbprint,$DaysToExpire | ConvertTo-Html| Out-File -FilePath c:\temp\thomas.html
Invoke-expression c:\temp\thomas.html

#endregion

#region here string - ignores single or dobule  quatoes - especially any type of external code like html, json, xml
$HTMLHeader = @'
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
'@
$HtmlOutuput = 'c:\temp\thomas1.html'
$Result = gci Cert:\LocalMachine\My | Select-Object -Property Thumbprint,$DaysToExpire | ConvertTo-Html -Head $HTMLHeader
# lets do a replace for an even better looking html where expired is red and bold! 
$result | ForEach-Object -Process {$_ -replace  '<td>Expired</td>','<td bgcolor="red" color ="white"><b><Font Color = "White">Expired</Font></b></td>'} | Out-File -FilePath $HtmlOutuput
Invoke-expression $HtmlOutuput

#endregion

#region Common External Commands and Powershell Replacements
# ping vs test-connection
$Result = ping EMREG-DESKTOP
get-member -InputObject $Result
$Result[-1]

(Test-Connection -ComputerName 'yahoo.com' | Measure-Object -Property Responsetime -Average -Maximum -Minimum).Average

# telnet vs - test-netconnection
Test-NetConnection -ComputerName 'emreg-desktop' -Port 445

#nslookup vs resolve-dns
$YahooIps=(Resolve-DnsName -Name yahoo.com -Type A).IpAddress

#ipconfig vs get-netipconfiguration
Get-NetIPConfiguration

#list ip address
(Get-NetIPAddress -PrefixOrigin Dhcp -AddressFamily IPv4).IPAddress

# netstat - get-nettcpconnection figure out connection issues
$ProcessName = @{

    Name = 'ProcessName'
    Expression = {(Get-Process -id $_.OWningProcess).ProcessName}

}

Get-NetTCPConnection -State Established -RemotePort 443 | Select-Object -Property RemoteAddress, $ProcessName | Where-Object -FilterScript {$_.PRocessName -eq 'teams'}

#endregion

#region Importing From Disk / Exporting to Disk
$TextPath = 'C:\temp\servers.txt'
$CsvPath = 'c:\temp\servers.csv'

#lets do the basic stuff first - read a text file.
$Content = Get-Content -Path $TextPath
Get-Member -InputObject $Content
# since this is an object array I can index into 
$Content[0]
$Content[-1]

#lets work with csv file
$CSVContent = Import-Csv -Path $CsvPath
# its again an object array
Get-Member -InputObject $CSVContent
# lets see what is the type of objects within the array by sneding the array to pipeline
$CSVContent | Get-Member

$CSVContent | Where-Object {$_.Memory -gt 4}

#endregion

#region AdvancedFunctions - Pipeline support - Convert to int if you can :)

Function ConvertTo-Int32 {

[Cmdletbinding()]
Param(

[Parameter(ValueFromPipeline=$true)]
[PSCustomObject]$InputObject
)


Process {
$ConverTedProperties = @{}

$Properties = ($_ | Get-Member -MemberType NoteProperty).Name
Foreach ($Property in $Properties) {


if ($Null -ne ($_.$Property -as [int32])) {

$ConverTedProperties.Add($Property,($_.$Property -as [int32]))

} else {

$ConverTedProperties.Add($Property,($_.$Property))

}

}


[PSCustomObject]$ConverTedProperties

}


}

$Servers = $CSVContent | ConvertTo-Int32
$Servers | Where-Object -FilterScript {$_.Memory -gt 8}
$Servers | gm
#endregion

#region AdvancedFunctions - Risk Mitigation

Function Delete-VirtualMachine {


[CmdletBinding(
    
    SupportsShouldProcess=$true,
    ConfirmImpact='High'

)]
Param(

[Parameter(ValueFromPipeline = $true)]
[string[]]$ServerName,
[String[]]$ExcludedServers

)

Process {
    Foreach ($Server in $ServerName) {
    if ($ExcludedServers -notcontains $Server -or $ExcludedServers.Count -eq 0) {
        
        if ($pscmdlet.ShouldProcess($Server, 'Deleting VM'))
        {
            "Deleted the vm: $Server"
        }
    }
        
    
    }
}
}

Delete-VirtualMachine -ServerName 'Server1'
Delete-VirtualMachine -ServerName 'Server1','Server2'
Get-content -Path $TextPath | Delete-VirtualMachine -WhatIf -ExcludedServers @('Server4.contoso.com')
Get-Content -Path $TextPath | Delete-VirtualMachine -Confirm:$false

Get-command -Name Delete-VirtualMachine -Syntax

#endregion

#region AdvancedFunction - Parameter Validation - continued


#validate script
Function Get-ServerList {

[Cmdletbinding()]
Param(
[ValidateScript({test-path $_})]
[string]$FilePath
)

$Content = get-content -Path $FilePath

"critical operation based on the content"

}

Get-ServerList -FilePath c:\temp\sthsth.txt

#validate stirng, integers and sets

Function Say-Hello {

[CmdletBinding()]
Param(
    [Parameter(ParameterSetName='x')]
    [ValidateLength(3,50)]
    [string]$Name,
    [Parameter(ParameterSetName='y')]
    [string]$FullName,
    [ValidateRange(18,150)]
    [int32]$Age,
    [ValidateSet('Male','Female')]
    [string]$Gender

)

Switch ($gender) {

  'Male' {
            if($PSCmdlet.ParameterSetName -eq 'x') {
                "Hello $Name. Congrats with your age $Age!"
             } else {
             
                "Hello Mr. $FullName. Congratulations with your age $Age. Anything I may help more?"
             }
                
         }
  'Female' {
        
        if($PSCmdlet.ParameterSetName -eq 'x') {
        "Hello $Name. are you really $([math]::Round(($Age/2+5))) : )" 
        } else {
        "Hello Miss. $FullName. are you really $([math]::Round(($Age/2+5))) mam? : )" 

        }
        }

}
}


Say-hello -Name 'Emre Guclu'  -Age 0
Say-hello -Name 'Emre'  -Age 45 -Gender 'Male'
Say-Hello -Name 'Miriam' -Age 35 -Gender 'Female'
Say-Hello -Name 'Miriam Surname' -Age 35 -Gender 'Female'


Say-Hello -FullName 'Carlos Velle' -Age 45 -Gender 'Male'
#endregion

#region Module Fundementals

# lists currently imported modules
Get-Module
# list all alvailable modules
Get-Module -ListAvailable

#Modules locations in windows
$env:PSModulePath -split ';'

Find-Module -Name *cluster*

Install-Module -Name Cluster -Scope AllUsers -AllowClobber -Force -Verbose

#endregion

#region Module - creating or own modules

# create a folder to work on
New-Item -Path 'C:\Temp' -Name 'PSUtil'  -ItemType Directory

<#

Module
1) .psd1 Module manifest = module configuration options
- version information
- requirements
- which functions to export.
2) .psm1: this file will include all functions
#>

# creating a manifest
$ModuleName = 'PSutil'
$ModulePath = "C:\temp\$ModuleName"
New-ModuleManifest -Path "$ModulePath\$ModuleName.psd1" -Author 'Emre Guclu' -CompanyName 'Contoso' -ModuleVersion '1.0.0.1'  -Description 'utility module for everyone'
psedit "$ModulePath\$ModuleName.psd1"

Copy-Item -Path $ModulePath -Destination 'C:\Program Files\WindowsPowerShell\Modules' -Recurse -Verbose -Force

psedit "C:\Program Files\WindowsPowerShell\Modules\$moduleName\$moduleName.psd1"

Get-Module -ListAvailable | where {$_.Name -eq $ModuleName }

Import-Module -Name $ModuleName -Verbose -Force
get-command -Module $ModuleName 
#endregion

#region error handling - introduction

# 1) CmdLet error - Nonterminating - can be Converted into terminating errors
Get-service -Name 'nonexistingservice','Spooler'

# system default is managed by $ErrorActionPreference
$ErrorActionPreference
e -Name 'nonexistingservice','Spooler' -ErrorAction Stop
Get-servic

# 2) Logical / Language Errors - Terminating - cannot convert to nonterminating errors
1 / 0
[int32]'sdf'

# 3) .net - Terminating - cannot convert to nonterminating errors
$Browser  = [System.Net.WebClient]::New()
$FileToDownloadURL = 'https://github.com/emrgcl/MonitorAccountLockouts/releases/download/1.0.0.30/SCOM.MonitorAccountLockouts_1.0.0.30.zip'
$FileToDownloadURLWrong = 'https://github.com/emrgcl/MonitorAccountLockouts/releases/download/1.0.0.30/SCOM.MonitorAccountLockouts_1.0.0.30___.zip'
$Browser.DownloadFile($FileToDownloadURLWrong, 'C:\temp\sth.zip')

# all errors to go $error (max 256)
$Error[0]


#endregion

#region legacy error handling
# $? returns the sucess state of the previous line
$LogPath = 'c:\temp\mylogfile.txt'
Get-Service -Name 'Spoolerxx' -ErrorAction SilentlyContinue
if (-not $?) {

"[$(Get-Date -Format G)] An  fatal error occured: $($Error[0].Exception.Message)" | Out-File -FilePath $LogPath -Append


}


#endregion

#region modern error handling using try catch finally


try {

#Get-Service -Name 'Spooler' -ErrorAction Stop
#1 / 0
$Browser  = [System.Net.WebClient]::New()
$FileToDownloadURL = 'https://github.com/emrgcl/MonitorAccountLockouts/releases/download/1.0.0.30/SCOM.MonitorAccountLockouts_1.0.0.30.zip'
#$FileToDownloadURLWrong = 'https://github.com/emrgcl/MonitorAccountLockouts/releases/download/1.0.0.30/SCOM.MonitorAccountLockouts_1.0.0.30___.zip'
$Browser.DownloadFile($FileToDownloadURL, 'C:\temp\sth.zip')
$Log = "[$(Get-Date -Format G)] Sucessfully downloaded file."
}

Catch {

$Log = "[$(Get-Date -Format G)] An error occured. $($Error[0].Exception.Message)" 

}

# finally 
Finally {

$log | Out-File -FilePath $LogPath -Append
$webClient.Dispose()

}

Function Test-Port {
Param(
[Parameter(Mandatory = $true)]
[string]$Hostname,
[Parameter(Mandatory = $true)]
[int32]$Port
)
try {
$TcpCLient = [System.Net.Sockets.TcpClient]::new()
$TcpCLient.Connect($Hostname,$Port)
$Connected = $true
}

catch {

$connected = $False

}
Finally {
[PScustomOBject]@{

    Hostname = $HostName
    Connected = $Connected
    Port = $Port


}
$TcpCLient.Dispose()
}
}
Test-Port -Hostname emreg-desktop -Port 446

#endregion

#region Powershell Remoting
$Servers = 'emreg-web01','emreg-web02','emreg-web03'

# Legacy remoting

Get-Service -Name ALG,Spooler -ComputerName $Servers # RPC TCP 135, 1024 | stop-ser

# list commands supporting computername parameter
Get-Command -ParameterName ComputerName

# Advanced Remoting - PSSession WSMaN (http 5985, httpssl 5986) - enabled on all servers using Enable-psremoting

$scriptBlock = {Get-Service -Name Alg,Spooler}

$SleepScript = {1..500 | ForEach-Object {'.';Start-Sleep -Seconds 1}}

# 1. Temporary Session (100'e kullan)
Invoke-Command -ComputerName $Servers -ScriptBlock $scriptBlock
foreach ($Server in $Servers) {

Invoke-Command -ComputerName $Server -ScriptBlock $scriptBlock

}
# 2. Persistent Session (1000 sunucu için daha mantıklıklı)
$session = New-PSSession -ComputerName $Servers
Invoke-command -Session $session[1] -ScriptBlock $SleepScript -AsJob 


Invoke-Command -Session $session -ScriptBlock $scriptBlock

Invoke-Command -Session $session -ScriptBlock $SleepScript

if ($session[1].Availability -eq 'Available') {

get-job |receive-job

}

Remove-PSSession -Session $session
#endregion
