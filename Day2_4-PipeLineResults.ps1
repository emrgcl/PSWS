# Format komutları ile pipeline çıktısını şekilendirmek
## format Table kuıllanımı
Get-Service | Format-Table

## Format-table ile genişleterek göstermek
Get-Service | Format-Table -AutoSize -Property *
gci | Format-Table -AutoSize -Property *
gci | ft -Property *

# format-list ile tüm propertyleri görmek
gci | Format-List -Property * -Force


# Export komutlar ile pipeline çıktısı farklı dosya türlerine aktarabiliriz.
gci | Export-Csv -Path c:\Filelist.csv
gci | Export-Clixml -Path c:\filelist.xml