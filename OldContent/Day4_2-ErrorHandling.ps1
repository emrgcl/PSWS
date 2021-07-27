# Error Handling

# Powershell Doğası
$ErrorActionPreference

# Continue davranışna örnek
Get-Service -Name Spooler,olmayanervis

# Continue davranışını terminating'e dönüştirebiliriz.
Get-Service -Name Spooler,olmayanservis -ErrorAction Stop

## Acemiler için ERror Handling (non-Termating errors)
Get-Service -Name Spooler,olmayanservis -ErrorAction SilentlyContinue
if (!$?) {

Write-error "hiçbişi olmadı ise bile birşey olmuştur kesin"

}



## Profesyoneller için error handling (terminating errors)

### Termiating hatalar örnekler
<#

1) Runtime hataları 
    
    1/0

2) Object methodları

    $Object = [System.Net.WebClient]::new()
    $Object.DownloadFile('http://server1/emreg.doc')


#>

# try catch finally sadewce terminating hataları yakalar, non-terminating hatları terminateinge aşağıdaki dönüştererek try blocku içinde kullanabiliriz.
try {

Get-Service -Name Spooler,olmayanservis -ErrorAction Stop

} 
Catch {

throw "hiçbişi olmadı ise bile birşey olmuştur kesin"

}


# Daha gelişmiş bir örnek

try
{
    1/0
}
catch [DivideByZeroException]
{
    Write-Host "Divide by zero exception"
}
catch [System.Net.WebException],[System.Exception]
{
    Write-Host "Other exception"
}
finally
{
    Write-Host "cleaning up ..."
}
