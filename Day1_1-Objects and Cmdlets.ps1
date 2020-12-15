# PowerShell and Objects
# giren Object = Property + Methods => Member)
# OBject = Intance = Entity
# Class = Type

$Name = 'Emre'

# Weak Type Casting
$Age = [int32]'32'
$Age = 'Emre'

# Strong Type Casting
[int32]$MyAge = '43'

Get-Member -InputObject $Age


# Powershell = Objects + Cmdlets (get-service) + Language (if/switch/operators) + Features (pipeline, Provider)

# CMDLet (Module)

Get-command

# Noun kısmında service olan komutları getirir (özetle servisle ilgili komutları listeler)
Get-command -Noun Service

# Wildcard ile arama yapabiliriz
Get-command -Name *Service*

# ****** Komutu hangi parameterler ile nasıl çalıştırmalıyım? *******

Get-Command -Name stop-service -Syntax

# Komutun helpine erişmek için
Get-help -Name Stop-service -showwindow

# komutun örnek kullanımlarını görmek için
Get-Help -Name Stop-SErvice -examples

# How To - PowerShell öğrenmek için
get-help -Name *about_*

# Örneğin array'lerin powershelld kullanımını okumak için
Get-help about_Arrays -ShowWindow
