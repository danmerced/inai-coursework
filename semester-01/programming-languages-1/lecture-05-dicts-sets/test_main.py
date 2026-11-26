import unittest
import main as m

class CollectionsTests(unittest.TestCase):
    def test_unique(self): self.assertEqual(m.unique_visitors([1,2],[2,3],[1,4]),{1,2,3,4})
    def test_mutual(self): self.assertEqual(m.mutual_friends([1,2],[2,3]),{2})
    def test_exclusive(self): self.assertEqual(m.exclusive_products([1,2],[2,3]),{1,3})
    def test_phones(self): self.assertEqual(m.unique_phones(["a","a","b"]),{"a","b"})
    def test_subset(self):
        self.assertTrue(m.all_participants([1,2,3],[1,3]))
        self.assertFalse(m.all_participants([1,2],[3]))
    def test_prices(self): self.assertEqual(m.product_price({"tea":3},"tea"),3)
    def test_words(self): self.assertEqual(m.word_counts("A a, b!"),{"a":2,"b":1})
    def test_phone(self): self.assertIsNone(m.find_phone({"A":"1"},"B"))
    def test_grades(self): self.assertEqual(m.average_grades({"A":[4,5],"B":[]}),{"A":4.5})
    def test_employee(self): self.assertEqual(m.employee_info({"A":{"age":1}},"A"),{"age":1})
