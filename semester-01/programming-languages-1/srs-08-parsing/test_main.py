import csv
import tempfile
import unittest
from pathlib import Path
from main import parse_products, save_csv


class ParserTest(unittest.TestCase):
    def test_fixture(self):
        products = parse_products(Path(__file__).with_name("sample.html").read_text(encoding="utf-8"))
        self.assertEqual(len(products), 3)
        self.assertEqual(products[0], {"title": "Клавиатура", "price": "1200.00"})

    def test_invalid(self):
        self.assertEqual(parse_products('<article class="product"><h2>A</h2><span class="price">NaN</span></article>'), [])
        self.assertEqual(parse_products('<article class="product"><h2>A</h2></article>'), [])

    def test_export(self):
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / "products.csv"
            save_csv([{"title": "A", "price": "1.23"}], path)
            with path.open(encoding="utf-8", newline="") as file:
                self.assertEqual(list(csv.DictReader(file)), [{"title": "A", "price": "1.23"}])
