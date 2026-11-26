$ErrorActionPreference = 'Stop'
$work = Join-Path ([System.IO.Path]::GetTempPath()) ("inai-ps-" + [guid]::NewGuid().ToString())
New-Item -Path $work -ItemType Directory | Out-Null
try {
    $file = Join-Path $work 'notes.txt'
    Set-Content -Path $file -Value @('Operating systems','PowerShell','File operations')
    Copy-Item -Path $file -Destination (Join-Path $work 'copy.txt')
    Get-ChildItem -Path $work | Select-Object Name, Length
    Get-Content -Path $file
    Get-FileHash -Path $file
    Get-Process | Sort-Object WorkingSet -Descending | Select-Object -First 5 Name, Id, WorkingSet
    Get-CimInstance Win32_OperatingSystem | Select-Object Caption, Version, TotalVisibleMemorySize, FreePhysicalMemory
    Compress-Archive -Path $file -DestinationPath (Join-Path $work 'notes.zip')
    Rename-Item -Path (Join-Path $work 'copy.txt') -NewName 'renamed.txt'
} finally {
    Remove-Item -LiteralPath $work -Recurse -Force
}
