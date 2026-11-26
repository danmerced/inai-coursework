import unittest
from main import bank,XOR_cipher,XOR_uncipher,calculate

class FunctionTests(unittest.TestCase):
    def test_bank(self):
        self.assertAlmostEqual(bank(1000,2),1210)
        self.assertEqual(bank(1000,0),1000)
    def test_xor(self):
        self.assertEqual(XOR_uncipher(XOR_cipher("Привет Python",42),42),"Привет Python")
        self.assertNotEqual(XOR_cipher("Hello",42),"Hello")
    def test_calculate(self):
        for op,expected in [("+",8),("-",4),("*",12),("/",3)]:
            self.assertEqual(calculate(6,op,2),expected)
        with self.assertRaises(ZeroDivisionError):
            calculate(1,"/",0)
