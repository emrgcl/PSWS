# ScriptBlock Type
$ScriptBlock = {


$_.Name -eq 'Spooler'


}

Get-Service | Where-Object -FilterScript $ScriptBlock

get-command invoke-command -Syntax

# Static MemberLarı görmek için 2 yol var
# :: ile classın üzerindeki static memberrlara ise üzerinde erişelbilinir (intellisense desteği ile)
[int32]::MaxValue

# get-member -static paramteresi kullanılarak object yerine class get-membera gönderilerek static memberlar listelenebilinir.
[int32] | get-member -Static


$mydouble = 9.23423423423423432342342342342

[Math]::Round($mydouble,2)

# Providers

