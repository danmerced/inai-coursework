import argparse
import csv
from html.parser import HTMLParser
from pathlib import Path
from decimal import Decimal, InvalidOperation


class ProductParser(HTMLParser):
    """Разбирает карточки вида article.product > h2 и span.price."""

    def __init__(self):
        super().__init__()
        self.products = []
        self.product = None
        self.field = None
        self.buffer = []

    def handle_starttag(self, tag, attrs):
        classes = dict(attrs).get("class", "").split()
        if tag == "article" and "product" in classes:
            self.product = {}
        elif self.product is not None:
            if tag == "h2":
                self.field = "title"
            elif tag == "span" and "price" in classes:
                self.field = "price"
            if self.field and tag in ("h2", "span"):
                self.buffer = []

    def handle_endtag(self, tag):
        if self.field and ((tag == "h2" and self.field == "title")
                           or (tag == "span" and self.field == "price")):
            self.product[self.field] = " ".join("".join(self.buffer).split())
            self.field = None
        if tag == "article" and self.product is not None:
            if self.product.get("title") and self.product.get("price"):
                try:
                    price = Decimal(self.product["price"])
                    if price.is_finite() and price >= 0:
                        self.products.append({"title": self.product["title"], "price": str(price)})
                except InvalidOperation:
                    pass
            self.product = None
            self.field = None

    def handle_data(self, data):
        if self.field is not None:
            self.buffer.append(data)


def parse_products(html):
    parser = ProductParser()
    parser.feed(html)
    parser.close()
    return parser.products


def save_csv(products, target):
    with Path(target).open("w", encoding="utf-8", newline="") as file:
        writer = csv.DictWriter(file, fieldnames=["title", "price"])
        writer.writeheader()
        writer.writerows(products)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--file", type=Path, default=Path(__file__).with_name("sample.html"))
    parser.add_argument("--url")
    parser.add_argument("--output", type=Path, default=Path("products.csv"))
    args = parser.parse_args()
    if args.url:
        import requests
        response = requests.get(args.url, timeout=10)
        response.raise_for_status()
        html = response.text
    else:
        html = args.file.read_text(encoding="utf-8")
    products = parse_products(html)
    save_csv(products, args.output)
    print(f"Сохранено карточек: {len(products)}")


if __name__ == "__main__":
    main()
