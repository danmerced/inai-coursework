import unittest
from main import average_temperature


class AverageTemperatureTests(unittest.TestCase):
    def test_positive_measurements(self):
        self.assertEqual(average_temperature([10, 12, 14]), 12)

    def test_negative_measurements(self):
        self.assertEqual(average_temperature([-12, -6, -3]), -7)

    def test_fractional_measurements(self):
        self.assertAlmostEqual(average_temperature([2.5, 3.0, 3.5]), 3.0)

    def test_single_measurement(self):
        self.assertEqual(average_temperature([5]), 5)


if __name__ == "__main__":
    unittest.main()
