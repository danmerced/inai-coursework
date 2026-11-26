import unittest
from main import is_email, extract_dates, normalize_spaces, extract_phones, repeated_words


class RegexTest(unittest.TestCase):
    def test_email(self):
        self.assertTrue(is_email("student@example.com"))
        self.assertFalse(is_email("bad@"))
        self.assertFalse(is_email("a b@example.com"))

    def test_dates(self):
        self.assertEqual(extract_dates("01.01.2024 и 99.01.2024"), ["01.01.2024"])

    def test_spaces(self):
        self.assertEqual(normalize_spaces("  a\t b\n c "), "a b c")

    def test_phones(self):
        self.assertEqual(extract_phones("+996 000 000 000; +9960000000000"), ["+996 000 000 000"])

    def test_words(self):
        self.assertEqual(repeated_words("Да да, нет"), ["Да"])


if __name__ == "__main__":
    unittest.main()
