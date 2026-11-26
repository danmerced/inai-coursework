import unittest
from unittest.mock import patch
from main import filter_numbers, first_multiple, guess_game

class LoopTests(unittest.TestCase):
    def test_filter(self):
        self.assertEqual(filter_numbers([12,3,45,67,8,9,10]),[12,45])
    def test_multiple(self):
        self.assertEqual(first_multiple([2,6,9,12,15,20,25,30]),15)
        self.assertIsNone(first_multiple([2,3,5]))
    @patch("main.random.randint", return_value=4)
    @patch("builtins.input", side_effect=["3","4"])
    def test_guess(self, mock_input, mock_random):
        guess_game()
        self.assertEqual(mock_input.call_count,2)
        mock_random.assert_called_once_with(1,10)
