import requests
from calculator import add, subtract, multiply, divide


def request_data(url):
    response = requests.get(url, timeout=10)
    response.raise_for_status()
    return response.json()


if __name__ == "__main__":
    print(add(8, 2))
    print(subtract(8, 2))
    print(multiply(8, 2))
    print(divide(8, 2))

    url = input("URL JSON API: ").strip()
    try:
        print(request_data(url))
    except (requests.RequestException, ValueError) as error:
        print("Ошибка запроса:", error)
