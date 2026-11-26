@echo off
setlocal
set "WORK=%TEMP%\inai-cmd-%RANDOM%-%RANDOM%"
mkdir "%WORK%" || exit /b 1
pushd "%WORK%" || exit /b 1
mkdir docs backup
echo First file>docs\first.txt
echo Second file>docs\second.txt
copy /y docs\first.txt backup\copy.txt
ren backup\copy.txt renamed.txt
type docs\first.txt
fc docs\first.txt backup\renamed.txt
attrib +r backup\renamed.txt
attrib backup\renamed.txt
attrib -r backup\renamed.txt
dir /a
tree /f
move docs\second.txt backup\second.txt
del backup\second.txt
xcopy docs backup /i /y
echo ==== Processes ====
tasklist /fi "imagename eq cmd.exe"
taskkill /?
echo ==== Disk and memory inspection ====
dir
systeminfo
popd
echo Work directory: %WORK%
echo Delete this temporary directory after review.
endlocal
