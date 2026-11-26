"""Calculate the average temperature for each of Kyrgyzstan's seven regions."""

REGIONS = [
    "Баткенская",
    "Джалал-Абадская",
    "Иссык-Кульская",
    "Нарынская",
    "Ошская",
    "Таласская",
    "Чуйская",
]


def average_temperature(temperatures):
    return sum(temperatures) / len(temperatures)


def main():
    print("Средняя температура по областям Кыргызстана")
    print("Введите замеры в °C через пробел для каждой области.")
    averages = {}

    for region in REGIONS:
        while True:
            try:
                measurements = list(map(float, input(f"{region}: ").split()))
                if not measurements:
                    print("Введите хотя бы один замер.")
                    continue
                averages[region] = average_temperature(measurements)
                break
            except ValueError:
                print("Введите только числа через пробел.")

    print("\nСредние температуры:")
    for region, temperature in averages.items():
        print(f"{region} область: {temperature:.2f} °C")


if __name__ == "__main__":
    main()
