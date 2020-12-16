# Alias
## Aliasları listelemek için
Get-Alias
## bir aliasın hangi komuta bağlı olduğunu görmek için
Get-Alias gci
get-alias dir
Get-Alias cd

# where-object için çeşitli alias kullanımları
gci | ? {$_.CreationTime -gt ([datetime]::Today - 5)}
gci | where {$_.CreationTime -gt ([datetime]::Today - 5)}

# yukarıdaki örneğin Clean code ideal satırı
Get-ChildItem | Where-Object -FilterScript {$_.CreationTime -gt ([datetime]::Today - 5)}

# alias oluşturmak veya yönetmek için komutlar.
get-command -Noun Alias

# Parameter Binding verdiğin değerleri sıradan ilgili parameterelere bağlamaya çalışır
set-location c:\ # dendiğpinde aslında arka planda c:\ stringini -path isimli parametreye bağlar.