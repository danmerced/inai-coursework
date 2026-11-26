from pathlib import Path
from itertools import combinations
import csv

def load():
    with (Path(__file__).parent / "transactions.csv").open() as f:
        return [set(row["items"].split(";")) for row in csv.DictReader(f)]

def apriori(transactions, min_support=.3):
    if not transactions:
        return {}
    universe = sorted(set.union(*transactions))
    counts = {}
    candidates = {frozenset([i]) for i in universe}
    size = 1
    while candidates:
        level = {}
        for items in candidates:
            support = sum(items <= t for t in transactions) / len(transactions)
            if support >= min_support:
                level[items] = support
        counts.update(level)
        size += 1
        frequent = list(level)
        candidates = set()
        for left,right in combinations(frequent,2):
            candidate = left | right
            if len(candidate)==size and all(frozenset(part) in level for part in combinations(candidate,size-1)):
                candidates.add(candidate)
    return counts

def rules(itemsets, min_confidence=.6):
    result = []
    for items, support in itemsets.items():
        for n in range(1,len(items)):
            for subset in combinations(sorted(items),n):
                lhs = frozenset(subset)
                rhs = items - lhs
                confidence = support / itemsets[lhs]
                if confidence >= min_confidence:
                    result.append((lhs,rhs,support,confidence,confidence/itemsets[rhs]))
    return sorted(result,key=lambda r:(-r[4],str(sorted(r[0])),str(sorted(r[1]))))

if __name__ == "__main__":
    transactions = load()
    items = apriori(transactions)
    for lhs,rhs,s,c,lift in rules(items):
        print(f"{', '.join(sorted(lhs))} -> {', '.join(sorted(rhs))}: support={s:.3f}, confidence={c:.3f}, lift={lift:.3f}")
