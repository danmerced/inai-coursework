import unittest
from main import (
    add_contact,
    combine_products,
    complete_last_task,
    count_purchases,
    tuple_example,
    update_products,
)


class ListsAndTuplesTests(unittest.TestCase):
    def test_update_products(self):
        products = ["Хлеб", "Чай"]
        self.assertEqual(update_products(products, "Чай", "Кофе"), ["Хлеб", "Кофе"])

    def test_insert_contact(self):
        self.assertEqual(add_contact(["Сергей", "Анна"], "Борис"), ["Анна", "Борис", "Сергей"])

    def test_insert_into_empty_contacts(self):
        self.assertEqual(add_contact([], "Анна"), ["Анна"])

    def test_count_purchases(self):
        self.assertEqual(count_purchases(["Молоко", "Хлеб", "Молоко"], "Молоко"), 2)
        self.assertEqual(count_purchases(["Хлеб"], "Молоко"), 0)

    def test_complete_last_task(self):
        tasks = ["Читать", "Программировать"]
        self.assertEqual(complete_last_task(tasks), "Программировать")
        self.assertEqual(tasks, ["Читать"])

    def test_empty_tasks(self):
        self.assertIsNone(complete_last_task([]))

    def test_combine_products(self):
        self.assertEqual(combine_products(["Телефон"], ["Мышь", "Клавиатура"]),
                         ["Телефон", "Мышь", "Клавиатура"])

    def test_tuple_operations(self):
        result = tuple_example()
        self.assertEqual(result["first"], 4)
        self.assertEqual(result["slice"], (5, 3))
        self.assertEqual(result["length"], 4)
        self.assertEqual(result["combined"], (4, 5, 3, 5, 4))
        self.assertEqual(result["repeated"], (1, 2, 1, 2))
        self.assertTrue(result["contains_five"])
        self.assertEqual(result["count_five"], 2)
        self.assertEqual(result["index_three"], 2)
        self.assertEqual(result["as_list"], [4, 5, 3, 5])


if __name__ == "__main__":
    unittest.main()
