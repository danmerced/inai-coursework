# Операционные системы и компьютерная архитектура

| Практика | Материалы |
|---|---|
| CMD №1: команды системы | [lab-01-cmd.bat](lab-01-cmd.bat) |
| CMD №2: файлы, процессы, диски | [lab-02-files.bat](lab-02-files.bat) |
| PowerShell: файлы и ресурсы | [lab-03-powershell.ps1](lab-03-powershell.ps1) |
| Linux: CLI, разрешения, архивы, процессы | [lab-04-linux.sh](lab-04-linux.sh) |
| Процессы и память | [process-demo.c](process-demo.c), [memory-demo.c](memory-demo.c) |
| Windows: реестр | [windows-registry.md](windows-registry.md) |
| Установка ОС и ФС | [installation-and-filesystems.md](installation-and-filesystems.md) |

Linux и программы C выполнены, вывод — [results.md](results.md). Запуск: `bash lab-04-linux.sh`, `gcc process-demo.c -o process-demo && ./process-demo`, аналогично memory-demo.c.

### CMD и Windows

В отдельной VM открыть CMD через диспетчер задач, изучить свойства окна и команды HELP, VER, DATE, TIME. Для изменения даты/времени создать снимок VM, временно отключить синхронизацию времени только в VM, изменить параметр, проверить и восстановить дату, время и синхронизацию. Скрипт выводит дату и время без их изменения.

Для TASKKILL открыть отдельный Блокнот без несохранённых документов, найти PID через TASKLIST и завершить именно тестовый процесс командой `taskkill /PID номер`. Не завершать системные процессы. Для диска использовать проверку без исправления, форматирование выполнять исключительно на пустом виртуальном диске. BAT и PowerShell необходимо выполнить в Windows; реальные результаты и снимки VM ещё не получены. Полные условия отдельных ЛБ 1–3 и Linux-методички пока отсутствуют.
