# Настройки Windows через реестр

Учебная работа на снимке виртуальной машины. Не изменять политики безопасности и параметры системной учётной записи.

В CMD сначала прочитать параметр отображения расширений:

```bat
reg query "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt
```

Сохранить исходное значение и экспортировать ветку в файл резервной копии через regedit. В VM установить HideFileExt (DWORD) в 0 для отображения расширений файлов, перезапустить Проводник через диспетчер задач и проверить отображение. После опыта вернуть исходное значение; если параметр не существовал, удалить только созданное значение.

Для знакомства с хранилищем безопасно использовать отдельный учебный раздел:

```bat
reg add "HKCU\Software\INAI_OS_Lab" /v DemoSetting /t REG_DWORD /d 1
reg query "HKCU\Software\INAI_OS_Lab"
reg export "HKCU\Software\INAI_OS_Lab" "%TEMP%\inai-os-demo.reg" /y
reg delete "HKCU\Software\INAI_OS_Lab" /f
```

Выполнять только если такого раздела не было до практики. Снимки и результат Windows необходимо получить в VM.
