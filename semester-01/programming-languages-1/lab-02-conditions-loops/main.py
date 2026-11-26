"""Лабораторная работа 2: условия и циклы."""
import random

def strong_password(password):
    has_digit = False
    has_letter = False
    for char in password:
        if char.isdigit():
            has_digit = True
        if char.isalpha():
            has_letter = True
    return len(password) >= 8 and has_digit and has_letter

def discounted_price(price, age):
    if price < 0 or age < 0:
        raise ValueError("Цена и возраст должны быть неотрицательными")
    if age < 18:
        return price * 0.8
    if age > 60:
        return price * 0.7
    return price

def count_letters(word):
    vowels = "аеёиоуыэюяaeiou"
    consonants = "бвгджзйклмнпрстфхцчшщbcdfghjklmnpqrstvwxyz"
    v = c = 0
    for letter in word.lower():
        if letter in vowels:
            v += 1
        elif letter in consonants:
            c += 1
    return v, c

def multiplication_table():
    table = []
    for i in range(1, 11):
        row = []
        for j in range(1, 11):
            row.append(i * j)
        table.append(row)
    return table

def min_max(numbers):
    if not numbers:
        raise ValueError("Нужен хотя бы один элемент")
    lowest = highest = numbers[0]
    for number in numbers:
        if number < lowest:
            lowest = number
        if number > highest:
            highest = number
    return lowest, highest

def cash_bills(amount):
    if amount <= 0 or amount % 100:
        raise ValueError("Сумма должна быть положительной и кратной 100")
    result = {}
    for bill in (5000, 1000, 500, 100):
        result[bill] = amount // bill
        amount = amount % bill
    return result

def guess_hint(secret, guess):
    if guess < secret:
        return "Больше"
    if guess > secret:
        return "Меньше"
    return "Угадал!"

def guessing_game():
    secret = random.randint(1, 100)
    while True:
        guess = int(input("Число от 1 до 100: "))
        result = guess_hint(secret, guess)
        print(result)
        if result == "Угадал!":
            break

def weekly_steps(days):
    if len(days) != 7 or any(x < 0 for x in days):
        raise ValueError("Необходимы 7 неотрицательных значений")
    total = 0
    for number in days:
        total += number
    return total, total / 7

def is_prime(number):
    if number < 2:
        return False
    for divisor in range(2, number):
        if number % divisor == 0:
            return False
    return True

def even_numbers(start, end):
    result = []
    for number in range(start, end + 1):
        if number % 2 == 0:
            result.append(number)
    return result

def cheap_purchases(purchases):
    result = []
    for name, price in purchases:
        if price < 100:
            result.append((name, price))
    return result

def multiples_of_seven():
    result = []
    for number in range(1, 101):
        if number % 7 == 0:
            result.append(number)
    return result

def count_spaces(text):
    return text.count(" ")

def translate(text):
    return text.replace("@", "а").replace("#", "о")

def queue_from_names(names):
    queue = []
    for name in names:
        if name.lower() == "стоп":
            break
        queue.append(name)
    return queue

def main():
    print("Лабораторная 2: выберите задачу 1–15 (0 — выход)")
    while True:
        try:
            task = int(input("Номер задачи: "))
            if task == 0:
                break
            if task == 1:
                print("Пароль надёжный" if strong_password(input("Пароль: ")) else "Пароль слишком простой")
            elif task == 2:
                print(f"{discounted_price(float(input('Цена: ')), int(input('Возраст: '))):.2f}")
            elif task == 3:
                v, c = count_letters(input("Слово: "))
                print("Гласных:", v, "Согласных:", c)
            elif task == 4:
                for row in multiplication_table():
                    print(" ".join(f"{x:3}" for x in row))
            elif task == 5:
                print("Минимум и максимум:", min_max([float(n) for n in input("Числа: ").split()]))
            elif task == 6:
                for bill, quantity in cash_bills(int(input("Сумма: "))).items():
                    print(bill, ":", quantity)
            elif task == 7:
                guessing_game()
            elif task == 8:
                total, average = weekly_steps([int(input(f"День {i}: ")) for i in range(1, 8)])
                print("Всего:", total, "Среднее:", average)
            elif task == 9:
                print("Простое" if is_prime(int(input("Число: "))) else "Не простое")
            elif task == 10:
                print(*even_numbers(int(input("Начало: ")), int(input("Конец: "))))
            elif task == 11:
                purchases = []
                while True:
                    name = input("Товар (пустая строка — конец): ").strip()
                    if not name:
                        break
                    purchases.append((name, float(input("Цена: "))))
                print(cheap_purchases(purchases))
            elif task == 12:
                print(*multiples_of_seven())
            elif task == 13:
                print(count_spaces(input("Строка: ")))
            elif task == 14:
                print(translate(input("Строка: ")))
            elif task == 15:
                names = []
                while True:
                    name = input("Имя (стоп — конец): ")
                    names.append(name)
                    if name.lower() == "стоп":
                        break
                print(*queue_from_names(names), sep="\n")
            else:
                print("Выберите номер от 1 до 15.")
        except ValueError as error:
            print("Некорректный ввод:", error)

if __name__ == "__main__":
    main()
