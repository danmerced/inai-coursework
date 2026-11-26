import argparse
import csv
import platform
import subprocess
from pathlib import Path

ALGORITHMS = ["counting", "radix", "bubble", "selection", "insertion", "shell",
              "merge", "heap", "quick", "binary_insertion", "msd"]
VARIANTS = [
    ("counting","bubble","merge"), ("radix","selection","heap"),
    ("counting","insertion","quick"), ("radix","shell","merge"),
    ("counting","bubble","heap"), ("radix","selection","quick"),
    ("counting","insertion","merge"), ("radix","shell","heap"),
    ("counting","bubble","quick"), ("radix","selection","merge"),
    ("counting","insertion","heap"), ("radix","shell","quick"),
]


def choose(n, colloquium):
    if colloquium == 2:
        if not 1 <= n <= 25:
            raise ValueError("Вариант второго коллоквиума: 1–25")
        return ("counting","selection","merge") if n == 25 else VARIANTS[(n-1)%12]
    if n < 1:
        raise ValueError("Номер студента должен быть положительным")
    variant = n % 16 + 1
    if variant == 15:
        return ("counting","shell","quick")
    if variant == 16:
        return ("radix","insertion","merge")
    return VARIANTS[(variant-1)%12]


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--number", type=int)
    parser.add_argument("--colloquium", type=int, choices=(2,3), default=2)
    parser.add_argument("--timeout", type=float, default=5)
    parser.add_argument("--output", default="results.csv")
    args = parser.parse_args()
    if args.timeout <= 0:
        raise ValueError("timeout должен быть положительным")
    root = Path(__file__).resolve().parent
    program = root/"sorting"
    subprocess.run(["gcc","-std=c11","-O2",str(root/"sorting.c"),"-o",str(program)], check=True)
    algorithms = choose(args.number,args.colloquium) if args.number is not None else ALGORITHMS
    with (root/args.output).open("w", encoding="utf-8", newline="") as file:
        writer = csv.writer(file)
        writer.writerow(["algorithm","size","seconds","comparisons","swaps","writes","status"])
        for name in algorithms:
            for n in (100,1000,10000,150000,1000000):
                try:
                    output=subprocess.check_output([str(program),name,str(n)], text=True, timeout=args.timeout)
                    row=[name,n,*output.strip().split(","),"ok"]
                except subprocess.TimeoutExpired:
                    row=[name,n,"","","","",f"timeout {args.timeout:g}s"]
                writer.writerow(row)
                file.flush()
                print(*row,flush=True)
    print(platform.platform())


if __name__ == "__main__":
    main()
