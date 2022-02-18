#region Discovering Objects

Get-Service Spooler

Get-SErvice Spooler | Get-Member

$Message = 'Merhaba Yunus Emre!'
$Message  | Get-Member
$Message.Length | Get-Member
$Message.Substring(0,3)

#endregion
# string parse / değiştirmek - regex
'Contoso\ie_icetin'
#'contoso\icetin' => Contoso\ismailc
# sunucu üzerindeki kritik servislerin durumnunu raporla
# kubernetes depolyment yaml'da namespace değiştirmek
# IISLogunda belirli bir ip varsa bir log dasyasına alarm satırı oluştur.
# manual serviceler var server restart olduktan sonra belirli bir sırayla başlatmak istiyorsun ve bir servisin başladığına emin olduktan sonra yapsın. ve yarım saatte bir bu serviceslerin başladığına emin olsun

# Wildcard -Like
'hededo.txt' -like '*.txt'

# emreg@microsoft.com

#regex -match
'hedehodo.txt' -match 'txt'

"emre `ne yapiyorsun"
$Name = 'Yunus Emre'

'Merhaba $Name'
'Merhba' + ' ' + $Name 
"Merhaba $Name. 100 try bugün kaç `$yapacak. Ulan bu ben bu Emre``nin..."

<#
    Escape Character
    PowerShell - `
    Regex - \

    1) birincil işini yapma 
    2) ikincil işini yap

    Karatkersen komut  ol, komutsan karakter ol

    Regex
    -----
    \d
#>

$ServerListStr = 'Server1,Server2,Server3,Server4'
($ServerListStr -split ',')[-1]
$ServerList='Server1','Server2','Server3','Server4'
$ServerList[-1]
('Server1','Server2','Server3','Server4')[-1]

$Text=@'
Volkan1
Yunus Emre2
Hakan3
Aydin4
'@

$Text -split '(?s)\d'

"Admin@contoso.comAdmin" -match 'A...n'

'emre.guclu' -match '\we\w\w'
'emre.guclu' -match '\w{1,3}'
$Matches
'em' -match '\w{1,3}'
$Matches

'192.168.0.1' -match '\d{1,3}.'
$Matches

# hedef ip'yi belirle
$IPFilePath = 'C:\repos\PhotographyModule\IP.txt'
$GatewayIP = '192.168.0.234'
$IPlist = Get-Content -Path $IPFilePath
$Counter = 0
$Result = Foreach ($IP in $IPlist) {
++$Counter  
# elimizdeki txt'te bir ip adresi varsa onu $foundip değişkenine koy
if($IP -match '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}') {
$FoundIP = $Matches[0]
}
# Foundip Gewayipsine eşitse bir iş yap
if ($FoundIP -eq $GatewayIP){

   $FoundIP
   $LineNumber = $Counter
}
}
if ($Result) {
    "The ip $Result is a gateway in line $LineNumber."
    
} else {
    "Aydin bulamadım abi napayım:)"
}

$Matches
'10.0.0.1' -match '\d{1,3}'
$Matches
'8.8.8.8' -match '\d{1,3}'
$Matches

if(1 -eq 1) {
    'hedehodo'
}


'xxx 999.999.9.999 xxxxxx' -match '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}'
$Matches

# static member
[math]::PI
[math] | Get-Member -Static
[math]::Round(2343242.786876)
[string]::IsNullOrEmpty($VolkanIsmailEmre)

# nesneyi constructor kullanarak oluştuırma
$Browser = [System.Net.WebClient]::new()

# new-object
$Browser = New-Object -TypeName System.Net.WebClient 


$Download = 'https://github.com/emrgcl/MonitorAccountLockouts/releases/download/1.0.0.30/SCOM.MonitorAccountLockouts_1.0.0.30.zip'
$Destination = 'C:\repos\PhotographyModule\SCOM.MonitorAccountLockouts_1.0.0.30.zip'
$Browser.DownloadFile($Download,$Destination)

'xxx 192.168.0.1 xxxxxx' -match '(?<IPAddress>\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})'
$Matches

'Contoso\Aydin' -match '\w{1,}\\\w{1,}'
'Contoso\Aydin' -match '(\w+)\\(\w+)'
$Username = $Matches[2]
$DomainName = $Matches[1]

'Contoso\Aydin' -match '(?<DomainName>\w+)\\(?<UserName>\w+)'
$Matches
$UserName = $Matches['UserName']
$DomainName = $Matches['DomainName']

"Username: $Username, DomainName: $domainName"

try {

    add-windowsfeature -Name 'Web-Server' -erroraction stop
new-ApplicationPool -PoolName 'MyApp' -erroraction stop
new-website -Website 'defaultWebsite' -erroraction stop
    
}
catch {

    Do-error remedation
    
}
finally {
    log issue
    cleanup
}
