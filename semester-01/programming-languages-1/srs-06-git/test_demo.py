import unittest
from demo import demo


class GitTest(unittest.TestCase):
    def test_workflow(self):
        log, status = demo()
        self.assertIn("Add example", log)
        self.assertIn("Initial demo", log)
        self.assertEqual(status, "")
