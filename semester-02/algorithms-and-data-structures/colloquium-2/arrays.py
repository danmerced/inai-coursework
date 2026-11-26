# Самостоятельные упражнения с массивами; индивидуальная методичка отсутствует.

def positive_sum(numbers):
    return sum(x for x in numbers if x > 0)


def reverse_array(numbers):
    for i in range(len(numbers)//2):
        j = len(numbers)-i-1
        numbers[i], numbers[j] = numbers[j], numbers[i]
    return numbers


def row_maximums(matrix):
    result = []
    for row in matrix:
        result.append(max(row))
    return result


def transpose(matrix):
    result = []
    for col in range(len(matrix[0])):
        row = []
        for i in range(len(matrix)):
            row.append(matrix[i][col])
        result.append(row)
    return result


if __name__ == "__main__":
    numbers = [5,-3,2,0,-7]
    matrix = [[1,2,3],[6,4,5]]
    print("Сумма положительных:", positive_sum(numbers))
    print("Обратный массив:", reverse_array(numbers))
    print("Максимумы:", row_maximums(matrix))
    print("Транспонирование:", transpose(matrix))
