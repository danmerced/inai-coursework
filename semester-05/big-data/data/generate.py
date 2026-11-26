from pathlib import Path
import csv
import random
from datetime import date, timedelta

HERE = Path(__file__).resolve().parent

def visits():
    rng = random.Random(7)
    with (HERE / "visits.csv").open("w", newline="") as f:
        w = csv.writer(f)
        w.writerow(["visit_id", "pages", "hour", "converted"])
        for i in range(900):
            center, daytime = [(3, 8), (10, 14), (18, 20)][i % 3]
            pages = max(1, round(rng.gauss(center, 2.0)))
            hour = min(23, max(0, round(rng.gauss(daytime, 2.0))))
            converted = int(rng.random() < min(0.8, 0.05 + pages * 0.025))
            w.writerow([i + 1, pages, hour, converted])

def rides_ml():
    rng = random.Random(17)
    with (HERE / "ride_history.csv").open("w", newline="") as f:
        w = csv.writer(f)
        w.writerow(["ride_id", "day", "distance_km", "hour", "rain", "cancelled", "duration_min"])
        for i in range(600):
            distance = round(rng.uniform(1, 25), 2)
            hour = rng.randrange(24)
            rain = int(rng.random() < .25)
            peak = 7 <= hour <= 9 or 17 <= hour <= 19
            probability = min(.9, .08 + .25 * rain + .18 * peak + .12 * (distance > 15))
            cancelled = int(rng.random() < probability)
            duration = round(max(4, 5 + 2.2 * distance + 8 * peak + 4 * rain + rng.gauss(0, 3)), 2)
            w.writerow([i + 1, date(2025, 1, 1) + timedelta(days=i), distance, hour, rain, cancelled, duration])

if __name__ == "__main__":
    visits()
    rides_ml()
