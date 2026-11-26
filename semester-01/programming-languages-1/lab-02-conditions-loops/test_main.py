import unittest
import main as m

class Lab2Tests(unittest.TestCase):
    def test_password(self):
        self.assertTrue(m.strong_password("abc12345"))
        self.assertFalse(m.strong_password("abcdefgh"))
    def test_discount(self):
        self.assertEqual(m.discounted_price(100,17),80)
        self.assertEqual(m.discounted_price(100,18),100)
        self.assertEqual(m.discounted_price(100,60),100)
        self.assertEqual(m.discounted_price(100,61),70)
    def test_letters(self):
        self.assertEqual(m.count_letters("Привет"),(2,4))
    def test_table(self):
        self.assertEqual(m.multiplication_table()[9][9],100)
        self.assertEqual(len(m.multiplication_table()),10)
    def test_min_max(self):
        self.assertEqual(m.min_max([-3,4,0,5]),(-3,5))
        with self.assertRaises(ValueError):
            m.min_max([])
    def test_cash(self):
        self.assertEqual(m.cash_bills(6700),{5000:1,1000:1,500:1,100:2})
        with self.assertRaises(ValueError):
            m.cash_bills(55)
    def test_guess(self):
        self.assertEqual(m.guess_hint(42,10),"Больше")
        self.assertEqual(m.guess_hint(42,50),"Меньше")
        self.assertEqual(m.guess_hint(42,42),"Угадал!")
    def test_steps(self):
        self.assertEqual(m.weekly_steps([100]*7),(700,100))
    def test_prime(self):
        self.assertTrue(m.is_prime(2))
        self.assertTrue(m.is_prime(19))
        self.assertFalse(m.is_prime(1))
        self.assertFalse(m.is_prime(21))
    def test_even(self):
        self.assertEqual(m.even_numbers(3,8),[4,6,8])
    def test_purchases(self):
        self.assertEqual(m.cheap_purchases([("A",99),("B",100)]),[("A",99)])
    def test_multiples(self):
        self.assertEqual(m.multiples_of_seven(),list(range(7,100,7)))
    def test_spaces(self):
        self.assertEqual(m.count_spaces(" a b  "),4)
    def test_translate(self):
        self.assertEqual(m.translate("@#"),"ао")
    def test_queue(self):
        self.assertEqual(m.queue_from_names(["Анна","Борис","СТОП","Вера"]),["Анна","Борис"])

if __name__ == "__main__":
    unittest.main()
