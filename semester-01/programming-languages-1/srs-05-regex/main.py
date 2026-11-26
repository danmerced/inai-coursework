import re


def is_email(value):
    """Учебная проверка распространённого формата, не полная реализация RFC."""
    return re.fullmatch(r"[\w.+-]+@[\w-]+(?:\.[\w-]+)+", value, flags=re.ASCII) is not None


def extract_dates(text):
    """Извлечение дат по формату ДД.ММ.ГГГГ без календарной валидации."""
    return re.findall(r"(?<!\d)(?:0[1-9]|[12]\d|3[01])\.(?:0[1-9]|1[0-2])\.\d{4}(?!\d)", text)


def normalize_spaces(text):
    return re.sub(r"\s+", " ", text).strip()


def extract_phones(text):
    """Пример формата +996 XXX XXX XXX."""
    return re.findall(r"(?<!\w)\+996[- ]?\d{3}[- ]?\d{3}[- ]?\d{3}(?!\d)", text)


def repeated_words(text):
    return re.findall(r"\b([^\W\d_]+)\s+\1\b", text, flags=re.IGNORECASE)


if __name__ == "__main__":
    print(is_email("student@example.com"))
    print(extract_dates("Лекция 01.09.2024"))
    print(normalize_spaces("Python    и\n Django"))
    print(extract_phones("Контакт +996 000 000 000"))
    print(repeated_words("да да нет"))
