# HashTables

## hastable oluşturmak
$Contact=@{ 

    Name = 'Emre'
    Surname = 'Guclu'
    Age = 43
    Profession = 'Engineer'

}

## Hashtable'a sorgu yapmak
$Contact.Name
$Contact['Name']

## hahstable'ın içeriğini dökmek
$Contact # lütfen dikkat edin hahstabledaki nesneler sıralı değildir.


## sıralı hastable oluşturmak için
$Contact=[ordered]@{ 

    Name = 'Emre'
    Surname = 'Guclu'
    Age = 43
    Profession = 'Engineer'

}

## keylerin listeisni dökmek için 
$Contact.Keys

## Hashtable'a programic olarak ekeleme yapmak için add methoduna önce key sonra value olacak şekilde parametre girilir
$Contact.Add('Gender','Male')

# creating a custom object
$ContactObj = [PsCustomObject]@{ 

    Name = 'Emre'
    Surname = 'Guclu'
    Age = 43
    Profession = 'Engineer'

}

$SystemDisk  = Get-WmiObject -Class win32_logicaldisk | Where {$_.Name -eq (get-WmiObject -Class win32_operatingSystem).Systemdrive}
$ServerInfo = [PscustomObject]@{

    
    OSName = (get-WmiObject -Class win32_operatingSystem).Caption
    MemoryGB = [math]::Round((get-WmiObject -Class win32_operatingSystem).TotalVisibleMemorySize * 1024 / 1gb)
    CPUCount = (Get-WmiObject -Class Win32_computersystem).numberoflogicalprocessors
    SystemDrive = (get-WmiObject -Class win32_operatingSystem).SystemDrive
    SystemDriveFreeSpacePercent = [Math]::Round(($SystemDisk.FreeSpace / $SystemDisk.Size * 100))



}

<# 
Kullanışlı WMI Classları
Win32_OperatingSystem
Win32_Computersystem
win32_logicaldisk


#>

# yukarıkdai kodun tasnif edilmiş daha temiz ve güzel hali

$OperatingSystem = get-WmiObject -Class win32_operatingSystem
$SystemDisk  = Get-WmiObject -Class win32_logicaldisk | Where {$_.Name -eq $OperatingSystem.Systemdrive}
$ServerInfo = [PscustomObject]@{

    
    OSName = $OperatingSystem.Caption
    MemoryGB = [math]::Round($OperatingSystem.TotalVisibleMemorySize * 1024 / 1gb)
    CPUCount = (Get-WmiObject -Class Win32_computersystem).numberoflogicalprocessors
    SystemDrive = $OperatingSystem.SystemDrive
    SystemDriveFreeSpacePercent = [Math]::Round(($SystemDisk.FreeSpace / $SystemDisk.Size * 100))

}
