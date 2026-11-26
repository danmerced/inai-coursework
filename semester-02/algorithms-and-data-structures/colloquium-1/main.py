import csv
import math
import sys
from pathlib import Path


def dichotomy(f, a, b, eps):
    rows = []
    calls = 0
    while b - a > eps:
        length = b - a
        x1 = (a + b) / 2 - eps / 4
        x2 = (a + b) / 2 + eps / 4
        y1, y2 = f(x1), f(x2)
        calls += 2
        old_a, old_b = a, b
        if y1 <= y2:
            b = x2
        else:
            a = x1
        rows.append([len(rows) + 1, old_a, old_b, length, (b-a)/length, x1, x2, y1, y2])
    return (a + b) / 2, calls, rows


def golden_section(f, a, b, eps):
    ratio = (math.sqrt(5) - 1) / 2
    rows = []
    if b - a <= eps:
        return (a + b) / 2, 0, rows
    x1 = b - ratio * (b-a)
    x2 = a + ratio * (b-a)
    y1, y2 = f(x1), f(x2)
    calls = 2
    while b - a > eps:
        old_a, old_b = a, b
        length = b-a
        a1, a2, f1, f2 = x1, x2, y1, y2
        if y1 <= y2:
            b = x2
            x2, y2 = x1, y1
            if b-a > eps:
                x1 = b - ratio * (b-a)
                y1 = f(x1)
                calls += 1
        else:
            a = x1
            x1, y1 = x2, y2
            if b-a > eps:
                x2 = a + ratio * (b-a)
                y2 = f(x2)
                calls += 1
        rows.append([len(rows)+1, old_a, old_b, length, (b-a)/length, a1, a2, f1, f2])
    return (a+b)/2, calls, rows


def fibonacci(f, a, b, eps):
    rows = []
    if b-a <= eps:
        return (a+b)/2, 0, rows
    fib = [0, 1]
    # Дополнительный запас для последней итерации, когда точки совпадают.
    while fib[-1] < 2*(b-a)/eps:
        fib.append(fib[-1] + fib[-2])
    n = len(fib)-1
    x1 = a + fib[n-2]/fib[n]*(b-a)
    x2 = a + fib[n-1]/fib[n]*(b-a)
    y1, y2 = f(x1), f(x2)
    calls = 2
    while n > 3 and b-a > eps:
        old_a, old_b = a, b
        length = b-a
        p, q, fp, fq = x1, x2, y1, y2
        n -= 1
        if y1 <= y2:
            b = x2
            x2, y2 = x1, y1
            if n > 3 and b-a > eps:
                x1 = a + fib[n-2]/fib[n]*(b-a)
                y1 = f(x1)
                calls += 1
        else:
            a = x1
            x1, y1 = x2, y2
            if n > 3 and b-a > eps:
                x2 = a + fib[n-1]/fib[n]*(b-a)
                y2 = f(x2)
                calls += 1
        rows.append([len(rows)+1, old_a, old_b, length, (b-a)/length, p, q, fp, fq])
    # Последний интервал при F3=2 уже не длиннее eps благодаря запасу.
    return (a+b)/2, calls, rows


def bracket_minimum(f, x0, step=0.1):
    if step <= 0:
        raise ValueError("Шаг должен быть положительным")
    center = f(x0)
    left, right = f(x0-step), f(x0+step)
    if left >= center and right >= center:
        return (x0-step, x0+step), [[1, x0-step, left, x0, center, x0+step, right]]
    direction = 1 if right < center else -1
    x1 = x0 + direction*step
    y1 = right if direction == 1 else left
    xprev, yprev = x0, center
    rows = []
    for i in range(1, 101):
        step *= 2
        x2 = x1 + direction*step
        y2 = f(x2)
        rows.append([i, xprev, yprev, x1, y1, x2, y2])
        if y2 >= y1:
            return tuple(sorted((xprev, x2))), rows
        xprev, yprev, x1, y1 = x1, y1, x2, y2
    raise ValueError("Интервал не найден")


def save_csv(path, header, rows):
    with path.open("w", newline="", encoding="utf-8") as file:
        writer = csv.writer(file)
        writer.writerow(header)
        writer.writerows(rows)


def run(variant, output):
    if not 1 <= variant <= 12:
        raise ValueError("Вариант методички: от 1 до 12")
    output.mkdir(parents=True, exist_ok=True)

    def f(x):
        return (x - variant)**2

    methods = {"dichotomy": dichotomy, "golden": golden_section, "fibonacci": fibonacci}
    counts = []
    for k in range(1, 8):
        eps = 10**(-k)
        row = [-k]
        for name, method in methods.items():
            x, calls, iterations = method(f, -2, 20, eps)
            assert abs(x-variant) <= eps
            row.append(calls)
            if k == 7:
                save_csv(output / (name+".csv"), ["step","a","b","length","ratio","x1","x2","f1","f2"], iterations)
            print(name, eps, "x =", round(x, 8), "calls =", calls)
        counts.append(row)
    save_csv(output / "counts.csv", ["log10_epsilon", *methods], counts)
    interval, rows = bracket_minimum(f, 0)
    save_csv(output / "bracket.csv", ["step","x_prev","f_prev","x","f","x_next","f_next"],rows)
    print("Initial interval:", interval)


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python main.py <variant 1..12>")
    else:
        run(int(sys.argv[1]), Path(__file__).with_name("results"))
