 # Указываем путь к файлу реестра (исходный шаблон .reg файл)
$regFileSource = "\\path_to_reg\file.reg"

# Определяем временную папку текущего пользователя
$tempFolder = [System.IO.Path]::GetTempPath()

# Определяем SID текущего пользователя
$userSID = (Get-WmiObject -Class Win32_UserAccount -Filter "Name='$env:USERNAME'").SID

# Определяем целевой файл во временной папке
$regFileTemp = Join-Path $tempFolder "modified_registry.reg"

# Читаем содержимое исходного файла реестра
$regContent = Get-Content -Path $regFileSource -Encoding Unicode

# Статический SID, который будем заменять
$oldSID = "S-1-5-21-3734670798-76392145-1373982661-1117"

# Заменяем статический SID на SID текущего пользователя
$updatedContent = $regContent -replace $oldSID, $userSID

# Записываем обновленный файл реестра во временную папку
$updatedContent | Out-File -FilePath $regFileTemp -Encoding Unicode

# Импортируем обновленный файл реестра
reg import $regFileTemp

# Указываем сетевую папку для копирования
$networkFolder = "\\path_to_source\Cert\My"

# Папка пользователя, куда нужно скопировать сетевую папку
$userFolder = "C:\Users\$env:USERNAME\AppData\Roaming\Microsoft\SystemCertificates"

# Копируем содержимое с заменой конфликтов
Copy-Item -Path $networkFolder -Destination $userFolder -Recurse -Force

Write-Host "Файл реестра был успешно импортирован, и папка скопирована."
 
