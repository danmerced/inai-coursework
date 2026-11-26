import random

def guess_game():
    secret = random.randint(1, 10)
    while True:
        guess = int(input("Угадайте число 1–10: "))
        if guess == secret:
            print("Угадали!")
            break
        print("Попробуйте ещё")

def filter_numbers(numbers):
    result = []
    for number in numbers:
        if number > 50:
            break
        if number <= 10:
            continue
        result.append(number)
    return result

def first_multiple(numbers):
    found = None
    for number in numbers:
        if number % 3 == 0 and number % 5 == 0:
            found = number
            break
    return found

if __name__ == "__main__":
    print(filter_numbers([12,3,45,67,8,9,10]))
    print(first_multiple([2,6,9,12,15,20,25,30]))
    guess_game()
