def unique_visitors(day1, day2, day3):
    return set(day1) | set(day2) | set(day3)

def mutual_friends(first, second):
    return set(first) & set(second)

def exclusive_products(first, second):
    return set(first) ^ set(second)

def unique_phones(phones):
    return set(phones)

def all_participants(registered, required):
    return set(required).issubset(registered)

def product_price(prices, name):
    return prices.get(name)

def word_counts(text):
    counts = {}
    for word in text.lower().split():
        word = word.strip(".,!?;:")
        if word:
            counts[word] = counts.get(word, 0) + 1
    return counts

def find_phone(book, name):
    return book.get(name)

def average_grades(students):
    return {name: sum(grades)/len(grades) for name, grades in students.items() if grades}

def employee_info(employees, name):
    return employees.get(name)

if __name__ == "__main__":
    print("1.", sorted(unique_visitors(["u1"],["u1","u2"],["u3"])))
    print("2.", sorted(mutual_friends(["A","B"],["B","C"])))
    print("3.", sorted(exclusive_products(["tea","milk"],["milk","bread"])))
    print("4.", sorted(unique_phones(["0001","0001","0002"])))
    print("5.", all_participants(["A","B","C"],["B","C"]))
    print("6.", product_price({"чай":50,"хлеб":30}, input("Продукт: ")))
    print("7.", word_counts("Мир мир Python."))
    print("8.", find_phone({"Demo":"0001"}, input("Имя контакта: ")))
    print("9.", average_grades({"Student A":[4,5,3],"Student B":[5,5]}))
    print("10.", employee_info({"Demo":{"age":30,"position":"developer"}}, input("Имя сотрудника: ")))
