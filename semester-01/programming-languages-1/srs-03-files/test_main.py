import tempfile
import unittest
from decimal import Decimal
from pathlib import Path
from PIL import Image
from main import (find_lines, numbered_lines, copy_image, add_expense, list_expenses,
                  total_sales, backup_texts, make_report, adjust_brightness,
                  save_config, load_config)


class FilesTest(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.root = Path(self.temp.name)
        self.addCleanup(self.temp.cleanup)

    def test_find(self):
        file = self.root / "a.txt"
        file.write_text("Python\nJava\npython rocks", encoding="utf-8")
        self.assertEqual(find_lines(file, "python"), ["Python", "python rocks"])

    def test_number(self):
        self.assertEqual(numbered_lines(self.root / "a.txt", ["one", "two"]), ["1. one", "2. two"])

    def test_copy(self):
        source, dest = self.root / "a.png", self.root / "b.png"
        Image.new("RGB", (2, 2), "red").save(source)
        copy_image(source, dest)
        self.assertEqual(source.read_bytes(), dest.read_bytes())

    def test_expenses(self):
        path = self.root / "expenses.csv"
        self.assertEqual(list_expenses(path), [])
        add_expense(path, "3.50", "еда", "2026-11-26")
        add_expense(path, "1.25", "проезд")
        self.assertEqual(len(list_expenses(path)), 2)
        self.assertEqual(list_expenses(path)[0]["amount"], "3.50")
        with self.assertRaises(ValueError):
            add_expense(path, "-1", "еда")

    def test_sales(self):
        path = self.root / "sales.csv"
        add_expense(path, "0.1", "a")
        add_expense(path, "0.2", "b")
        self.assertEqual(total_sales(path), Decimal("0.3"))

    def test_backup(self):
        source = self.root / "source"
        source.mkdir()
        (source / "a.txt").write_text("a")
        (source / "b.csv").write_text("b")
        result = backup_texts(source, self.root / "backup", "2026-11-26")
        self.assertEqual([p.name for p in result], ["a_2026-11-26.txt"])
        self.assertEqual(result[0].read_text(), "a")

    def test_report(self):
        a, b, out = [self.root / name for name in ("a.txt", "b.txt", "report.txt")]
        a.write_text("first")
        b.write_text("second")
        make_report([a, b], out)
        self.assertEqual(out.read_text(), "=== a.txt ===\nfirst\n\n=== b.txt ===\nsecond\n")

    def test_brightness(self):
        a, b = self.root / "a.png", self.root / "b.png"
        Image.new("RGB", (1, 1), (20, 40, 60)).save(a)
        adjust_brightness(a, b, 2)
        with Image.open(b) as image:
            self.assertEqual(image.getpixel((0, 0)), (40, 80, 120))

    def test_config(self):
        path = self.root / "settings.json"
        save_config(path, {"language": "русский", "enabled": True})
        self.assertEqual(load_config(path), {"language": "русский", "enabled": True})


if __name__ == "__main__":
    unittest.main()
