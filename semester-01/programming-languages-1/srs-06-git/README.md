# СРС 6 — Git и GitHub

Тема из [силлабуса](https://lms.inai.kg/Lesson/LessonViewNew/1196). Локальная демонстрация создаёт временный репозиторий, два коммита, ветку feature и слияние; затем выводит историю и проверяет состояние. История демонстрационного проекта не публикуется и не выдаётся за исторические работы.

```bash
python demo.py
python -m unittest -v
```

Работа с удалённым репозиторием:

```bash
git clone https://github.com/danmerced/inai-coursework.git
cd inai-coursework
git status
git log --oneline -5
```

Примеры реальной истории текущего восстановления: [СРС 2](https://github.com/danmerced/inai-coursework/commit/98ccba31c1a9a071ba44f91eb888a49b6e68d78a). В обычном рабочем процессе изменения добавляются через `git add`, затем `git commit -m "Описание"` и `git push` при наличии прав доступа.
