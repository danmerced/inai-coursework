"""Изолированная демонстрация Git, не затрагивающая пользовательские репозитории."""
import subprocess
import tempfile
from pathlib import Path


def demo():
    with tempfile.TemporaryDirectory(prefix="git-practice-") as directory:
        root = Path(directory)

        def git(*args):
            return subprocess.run(["git", *args], cwd=root, check=True,
                                  capture_output=True, text=True).stdout.strip()

        git("init", "-b", "main")
        git("config", "user.name", "Git Practice")
        git("config", "user.email", "demo@example.invalid")
        (root / "README.md").write_text("# Demo\n", encoding="utf-8")
        git("add", "README.md")
        git("commit", "-m", "Initial demo")
        git("switch", "-c", "feature")
        (root / "hello.py").write_text('print("Hello")\n', encoding="utf-8")
        git("add", "hello.py")
        git("commit", "-m", "Add example")
        git("switch", "main")
        git("merge", "feature")
        return git("log", "--oneline"), git("status", "--porcelain")


if __name__ == "__main__":
    log, status = demo()
    print(log)
    print("Рабочее дерево чистое:", not status)
