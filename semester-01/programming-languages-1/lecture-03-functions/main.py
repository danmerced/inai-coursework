def bank(a, years):
    for _ in range(years):
        a *= 1.1
    return a

def XOR_cipher(text, key):
    if not 0 <= key < 256:
        raise ValueError("Ключ — целое число от 0 до 255")
    # Учебная демонстрация XOR, не криптографическая защита.
    return "".join(chr(ord(letter) ^ key) for letter in text)

def XOR_uncipher(ciphertext, key):
    return XOR_cipher(ciphertext, key)

def calculate(a, op, b):
    if op == "+":
        return a + b
    if op == "-":
        return a - b
    if op == "*":
        return a * b
    if op == "/":
        return a / b
    raise ValueError("Операция должна быть +, -, *, /")

if __name__ == "__main__":
    print("Вклад:", round(bank(1000, 2), 2))
    encrypted = XOR_cipher("Привет", 42)
    print("XOR:", repr(encrypted), XOR_uncipher(encrypted, 42))
    print("Калькулятор:", calculate(float(input("a: ")), input("Операция: "), float(input("b: "))))
