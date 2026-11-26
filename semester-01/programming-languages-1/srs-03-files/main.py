"""Девять упражнений с текстовыми, табличными и бинарными файлами."""
import argparse
import csv
import json
import shutil
from datetime import date
from decimal import Decimal
from pathlib import Path

from PIL import Image, ImageEnhance


def find_lines(path, word):
    return [line for line in Path(path).read_text(encoding="utf-8").splitlines()
            if word.casefold() in line.casefold()]


def numbered_lines(path, lines):
    path = Path(path)
    path.write_text("\n".join(lines) + "\n", encoding="utf-8")
    return [f"{i}. {line}" for i, line in enumerate(
        path.read_text(encoding="utf-8").splitlines(), 1)]


def copy_image(source, target):
    shutil.copyfile(source, target)


def add_expense(path, amount, category, day=None):
    amount = Decimal(str(amount))
    if not amount.is_finite() or amount <= 0 or not category.strip():
        raise ValueError("Нужны положительная сумма и категория")
    path = Path(path)
    new_file = not path.exists() or path.stat().st_size == 0
    with path.open("a", encoding="utf-8", newline="") as file:
        writer = csv.writer(file)
        if new_file:
            writer.writerow(["date", "amount", "category"])
        writer.writerow([day or date.today().isoformat(), str(amount), category])


def list_expenses(path):
    if not Path(path).exists():
        return []
    with Path(path).open(encoding="utf-8", newline="") as file:
        return list(csv.DictReader(file))


def total_sales(path):
    with Path(path).open(encoding="utf-8", newline="") as file:
        return sum((Decimal(row["amount"]) for row in csv.DictReader(file)), Decimal("0"))


def backup_texts(source_dir, target_dir, day=None):
    target_dir = Path(target_dir)
    target_dir.mkdir(parents=True, exist_ok=True)
    copies = []
    for source in sorted(Path(source_dir).glob("*.txt")):
        target = target_dir / f"{source.stem}_{day or date.today().isoformat()}.txt"
        if target.resolve() != source.resolve():
            shutil.copy2(source, target)
            copies.append(target)
    return copies


def make_report(paths, target):
    sections = []
    for path in paths:
        path = Path(path)
        sections.append(f"=== {path.name} ===\n{path.read_text(encoding='utf-8').rstrip()}")
    Path(target).write_text("\n\n".join(sections) + "\n", encoding="utf-8")


def adjust_brightness(source, target, factor):
    if factor < 0:
        raise ValueError("Коэффициент не может быть отрицательным")
    with Image.open(source) as image:
        ImageEnhance.Brightness(image.convert("RGB")).enhance(factor).save(target)


def save_config(path, config):
    Path(path).write_text(json.dumps(config, ensure_ascii=False, indent=2), encoding="utf-8")


def load_config(path):
    return json.loads(Path(path).read_text(encoding="utf-8"))


def main():
    parser = argparse.ArgumentParser(description="Журнал расходов")
    parser.add_argument("--file", default="expenses.csv")
    commands = parser.add_subparsers(dest="command", required=True)
    add = commands.add_parser("add")
    add.add_argument("amount")
    add.add_argument("category")
    commands.add_parser("list")
    args = parser.parse_args()
    if args.command == "add":
        add_expense(args.file, args.amount, args.category)
        print("Расход записан")
    else:
        for row in list_expenses(args.file):
            print(row["date"], row["amount"], row["category"])


if __name__ == "__main__":
    main()
