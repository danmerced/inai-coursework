"""СРС №2: списки и кортежи, практические задачи лекции 4."""


def update_products(products, discontinued, new_product):
    """Задача 1. Удалить снятый с продажи товар и добавить новый."""
    products.remove(discontinued)
    products.append(new_product)
    return products


def add_contact(contacts, client):
    """Задача 2. Добавить клиента с сохранением алфавитного порядка."""
    contacts.sort()
    index = 0
    while index < len(contacts) and contacts[index] < client:
        index += 1
    contacts.insert(index, client)
    return contacts


def count_purchases(purchases, product):
    """Задача 3. Посчитать покупки выбранного товара."""
    return purchases.count(product)


def complete_last_task(tasks):
    """Задача 4. Удалить последнюю задачу и вернуть её название."""
    if not tasks:
        return None
    return tasks.pop()


def combine_products(products, new_products):
    """Задача 5. Расширить основной список дополнительным."""
    products.extend(new_products)
    return products


def tuple_example():
    """Дополнительный пример для темы кортежей из силлабуса."""
    grades = (4, 5, 3, 5)
    return {
        "first": grades[0],
        "slice": grades[1:3],
        "length": len(grades),
        "combined": grades + (4,),
        "repeated": (1, 2) * 2,
        "contains_five": 5 in grades,
        "count_five": grades.count(5),
        "index_three": grades.index(3),
        "as_list": list(grades),
    }


def main():
    products = ["Хлеб", "Молоко", "Чай"]
    print("1. Товары:", update_products(products, "Чай", "Кофе"))

    contacts = ["Анна", "Дмитрий", "Сергей"]
    print("2. Контакты:", add_contact(contacts, "Борис"))

    purchases = ["Хлеб", "Молоко", "Хлеб", "Хлеб"]
    print("3. Количество покупок хлеба:", count_purchases(purchases, "Хлеб"))

    tasks = ["Учёба", "Чтение", "Прогулка"]
    print("4. Выполнена:", complete_last_task(tasks))
    print("   Осталось:", tasks)

    print("5. Каталог:", combine_products(["Телефон", "Наушники"], ["Клавиатура", "Мышь"]))

    print("\nКортеж:")
    for operation, result in tuple_example().items():
        print(operation, "=", result)


if __name__ == "__main__":
    main()
