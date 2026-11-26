import unittest
from calculator import add, subtract, multiply, divide
from main import local_api, request_data


class ModulesTest(unittest.TestCase):
    def test_calculator(self):
        self.assertEqual((add(8, 2), subtract(8, 2), multiply(8, 2), divide(8, 2)), (10, 6, 16, 4))
        with self.assertRaises(ValueError):
            divide(1, 0)

    def test_http(self):
        with local_api() as url:
            self.assertEqual(request_data(url), {"status": "ok", "course": "Python"})
