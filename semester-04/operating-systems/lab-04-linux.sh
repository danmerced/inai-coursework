#!/usr/bin/env bash
set -euo pipefail
work=$(mktemp -d)
trap 'rm -rf -- "$work"' EXIT
cd "$work"
mkdir docs backup
printf 'Linux\nFile systems\nProcesses\n' > docs/notes.txt
cp docs/notes.txt backup/copy.txt
mv backup/copy.txt backup/renamed.txt
chmod 600 backup/renamed.txt
echo '=== Files and permissions ==='
stat -c "%A %s %n" docs/notes.txt backup/renamed.txt
echo '=== Search ==='
grep -n 'Processes' docs/notes.txt
find . -type f | sort
echo '=== Archive ==='
tar -czf archive.tar.gz docs
mkdir restored
tar -xzf archive.tar.gz -C restored
cmp docs/notes.txt restored/docs/notes.txt
echo 'Files match after extraction'
sha256sum docs/notes.txt restored/docs/notes.txt
echo '=== Process control ==='
sleep 60 &
pid=$!
ps -p "$pid" -o comm=,stat=
kill "$pid"
wait "$pid" || true
echo 'Child process terminated'
echo '=== System ==='
uname -srm
getconf PAGE_SIZE
echo '=== Storage ==='
du -ah docs backup archive.tar.gz | sort
