# Arrays and Pipeline

# Strings Advanced
$Sever = 'yabaddaaaa'
## Literal String
$name  = 'Emre $Sever'

## Expandle String
$name  = "Emre $Sever"

# SubExpression = Asprin

(Get-SErvice -Name Spooler).Name

# Variable SubExpression 
$Message = "working on $((Get-SErvice -Name Spooler).Name)"

# Array

#içi boş array oluşturmak
$Names = @()

# Arrayi oluşturken içine objectler atabiliriz.
$Names = @('Emre','Alper','Ahmet','Iskender',43,(Get-Service -Name Spooler))

$Names = 'Emre','Alper','Ahmet','Iskender',43,(Get-Service -Name Spooler)

Get-Member -InputObject $Names

# Arraye object 
$Names.Add('LEvent') # çalışmaz...

$Names += 'Levent' # Çalışır

[System.Collections.ArrayList]$NameList = @('Emre','Ahmet')

$NameList.Add('Alper')

# Arraydeki son elemanı çağırmak
$NameList[-1]

# range operator .. kullanarak array oluşturmak

$RangeofNumbers = 1..5 # 1'den 5'e kadar olan syılardan bir array oluşturduk

# array'e index olarak bir array verek bir index aralığını sorgulatbiliriz.
$Services[$RangeOfnumbers]

# Elemanın indexini öğrenmek
$NameList.IndexOf('Alper')

#Son indeksi öğrenmek için
$NameList.IndexOf(($NameList[-1]))

# Array Operators -contains

$NameList -contains 'Alper'

# Loop in an array

Foreach ($Service in Get-Service) {

if ($Service.Name -eq 'Spooler') {

"Wokring on $($Service.Name)"
}

}

# Forech yerine pipeline |

$Services | Where {$_.Name -eq 'Spooler'}

5 -gt 4

$ServiceOwners = Import-Csv -Path C:\temp\HVKKPSWS2\ServiceOwners.csv
$ServiceOwners | Stop-Service