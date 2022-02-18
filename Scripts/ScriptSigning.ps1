$params = @{
    Subject = 'CN=PowerShell Code Signing Cert'
    Type = 'CodeSigning'
    CertStoreLocation = 'Cert:\CurrentUser\My'
    HashAlgorithm = 'sha256'
}
# bir tane CodeSigning sertifikaya ihtiyaç var, istersen selfsigned istersen de PKI
$cert = New-SelfSignedCertificate @params
$File = 'C:\repos\PhotographyModule\Invoke-MasumOperation.ps1'
Set-AuthenticodeSignature $file $cert