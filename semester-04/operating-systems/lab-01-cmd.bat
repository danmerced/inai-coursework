@echo off
echo ==== System commands ====
ver
date /t
time /t
echo ==== HELP ====
help ver
help date
help time
help dir
echo ==== Resource and process information ====
tasklist /fi "imagename eq cmd.exe"
echo Use a disposable VM for date/time changes; see README.
