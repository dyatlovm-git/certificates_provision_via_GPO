# ps scripts



## Getting started

Скрит написан для упрощения распространения сертификатов пользователям Active Directory посредством GPO.



## Подготовительный этап

- [ ] Установить все сертификаты для Пользователя-Источника
- [ ] Скопировать папку My (C:\Users\user\AppData\Roaming\Microsoft\SystemCertificates\My) в папку на сетевом диске \\path_to_source\Cert\My
- [ ] Произвести выгрузку из реестра, для каждого из установленных сертификатов, ветки 
```
\HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Crypto Pro\Settings\Users\S-1-5-21-4126888996-1677807805-1843639151-1000\Keys
```
SID  данном случае совпадает с SID Пользователем-Источником


## License

This project is licensed under the [MIT License](./LICENSE) © 2025 Diatlov Mikhail

