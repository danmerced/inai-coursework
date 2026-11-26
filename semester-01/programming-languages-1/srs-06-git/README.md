# СРС 6 — Git и GitHub

Основные команды для работы с репозиторием.

```bash
git clone https://github.com/danmerced/inai-coursework.git
cd inai-coursework
git status
git log --oneline -5
git switch -c feature
```

После внесения изменений:

```bash
git add .
git commit -m "Update files"
git push -u origin feature
```

Пример коммита: [СРС 2](https://github.com/danmerced/inai-coursework/commit/98ccba31c1a9a071ba44f91eb888a49b6e68d78a).
