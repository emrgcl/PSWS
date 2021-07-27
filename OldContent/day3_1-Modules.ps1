# Modullerin aşağıdaki komutla dönen pahtlerden birine kopyalanması lazım
$env:PSModulePath -split ';'

<#

C:\Users\emreg\Documents\WindowsPowerShell\Modules
C:\Program Files\WindowsPowerShell\Modules
C:\Windows\system32\WindowsPowerShell\v1.0\Modules

#>

<# 

    Module Oluşturma akışı
    1) module klasörünü oluştur içine oluşturmak istediğin versiyon folderını da ekle
    2) version folderının içine modlüle ismi .psm1 dosyası ekle
    3) .psm1 dosyasının içine bütün fonksiyonlarını koy kaydet
    4) module manifesto dosyasını aşağıdaki örnek ile oluştur yine bu version klasörüne kaydet
    5) Manifeste dosyasında (psd1) azuladığın özellikeri aç kapat, değiştir (FunctionsToExport)
    6) memnun kalırsan Tüm folderı C:\Program Files\WindowsPowerShell\Modules klasörüne kopyala

#>
# Manifesto dosyası oluştur
New-ModuleManifest -Path C:\temp\ServerUtility\ServerUtility.psd1 -Author 'Emre Güçlü' -CompanyName 'Contoso.com' -RootModule 'ServerUtility.psm1'


<#

Örnek Module fodler hiyearşisi

    Directory: C:\temp\ServerUtility


Mode                 LastWriteTime         Length Name                                                          
----                 -------------         ------ ----                                                          
d-----        12/18/2020  11:26 AM                1.0                                                           


    Directory: C:\temp\ServerUtility\1.0


Mode                 LastWriteTime         Length Name                                                          
----                 -------------         ------ ----                                                          
-a----        12/18/2020  11:29 AM           7854 ServerUtility.psd1                                            
-a----        12/18/2020  11:21 AM            510 ServerUtility.psm1                                            




#>