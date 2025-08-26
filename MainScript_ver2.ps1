 # Задаем группы и соответствующие пути к скриптам для каждой группы
$groupScriptMap = @{
    "First Group" = "\\path\to_first_group\first_script.ps1"
    "Second Group" = "\\path\to_second_group\second_script.ps1"
}

# Получаем информацию о текущем пользователе
$user = [System.Security.Principal.WindowsIdentity]::GetCurrent()

$userGroups = $user.Groups | ForEach-Object { 
    $_.Translate([System.Security.Principal.NTAccount]).Value.Split("\")[1]
}

# Перебираем каждую группу из маппинга и проверяем, состоит ли в ней пользователь
foreach ($group in $groupScriptMap.Keys) {
    if ($userGroups -contains $group) {
        Write-Output "Пользователь $($user.Name) принадлежит группе $group."
        
        # Получаем путь к скрипту для этой группы
        $scriptPath = $groupScriptMap[$group]
        Write-Output "Запускается скрипт для группы: $scriptPath"
        
        # Выполняем соответствующий скрипт
        try {
            #Start-Process -FilePath "powershell.exe" -ArgumentList "-ExecutionPolicy Bypass -File $scriptPath" -NoNewWindow -Wait
            Start-Process -FilePath "powershell.exe" -ArgumentList "-ExecutionPolicy", "Bypass", "-File", "`"$scriptPath`"" -NoNewWindow -Wait

        } catch {
            Write-Output "Ошибка при выполнении скрипта для группы $[group]: $_"
        }
    } else {
        Write-Output "Пользователь $($user.Name) не состоит в группе $group."
    }
}
 
