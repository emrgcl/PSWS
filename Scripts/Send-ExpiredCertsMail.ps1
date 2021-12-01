Param(

[string]$EmailDBpath


)
Function New-CertObject {

Param(

[string]$Thumbprint,
[string]$OU

)

[PscustomObject]@{

    Thumbprint = $Thumbprint
    Ou = $OU


}

}

Function Send-CertEmail {

Param(
    
    [string]$Email,
    [string]$ThumbPrint

)

"Certificate Expired. Thumbprint = $Thumbprint, Email: $Email"


}
Function Get-EmailFromHashtable {

Param(

    $HashTable,
    $Ou

)



if ($HashTable.ContainsKey($Ou)) {

$HashTable.$Ou

} else {

$HashTable.Default

}

}

$EmailHashtable = Import-PowerShellDataFile -Path $EmailDBpath

$Cert1 = New-CertObject -Thumbprint 'xxxyyyccctttt234xxxx' -OU 'Infra Ou Guys'
$Cert2 = New-CertObject -Thumbprint 'ccctttjjjjkkkk234lll' -OU 'Middleware Heroes'
$cert3 = New-CertObject -Thumbprint 'lllleeewweeestt23llk' -OU 'App Management Workers'
$cert4 = New-CertObject -Thumbprint 'qqqeweeesss32452vvvv' -OU 'A new Ou that needs to be updated'

$Certs = @($cert1,$Cert2,$cert3,$cert4)

Foreach ($cert in $Certs) {


$Email = Get-EmailFromHashtable -HashTable $EmailHashtable -Ou $Cert.Ou
    
    
Send-CertEmail -ThumbPrint $Cert.Thumbprint -Email $Email

    
}