# Результаты запуска Linux

Фактический вывод команд в тестовой Linux-среде.

## Файлы, архивы и процессы
 ```text
=== Files and permissions ===
-rw-r--r-- 29 docs/notes.txt
-rw------- 29 backup/renamed.txt
=== Search ===
3:Processes
./backup/renamed.txt
./docs/notes.txt
=== Archive ===
Files match after extraction
b8963dc1fd499a50af6dade5059a013e9aa73eb2b44461a34b98fe21380445ff  docs/notes.txt
b8963dc1fd499a50af6dade5059a013e9aa73eb2b44461a34b98fe21380445ff  restored/docs/notes.txt
=== Process control ===
sleep           S
Child process terminated
=== System ===
Linux 6.18.57 x86_64
4096
=== Storage ===
4.0K	archive.tar.gz
4.0K	backup
4.0K	backup/renamed.txt
4.0K	docs
4.0K	docs/notes.txt
 ```

## fork и waitpid
 ```text
Child: calculation 12 + 8 = 20
Parent: child exit code = 7
 ```

## Управление памятью
 ```text
Page size: 4096 bytes
Allocated 16384 bytes, touched 4 pages
Memory released
 ```
