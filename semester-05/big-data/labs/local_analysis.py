"""Portable local demonstration. This is not a Spark execution."""
from pathlib import Path
import pandas as pd
import sqlite3
from sklearn.cluster import KMeans
from sklearn.metrics import adjusted_rand_score, confusion_matrix, mean_absolute_error, roc_auc_score
from sklearn.linear_model import LogisticRegression, LinearRegression
from sklearn.pipeline import make_pipeline
from sklearn.preprocessing import StandardScaler

DATA = Path(__file__).resolve().parents[1] / "data"

def quality():
    raw = pd.read_csv(DATA / "events_quality.csv", keep_default_na=False)
    events = raw.copy()
    events["city"] = events.city.str.strip().str.title()
    events["kind"] = events.kind.str.strip().str.lower()
    events["reason"] = ""
    events.loc[~events.kind.isin(["click", "view"]), "reason"] = "unknown_kind"
    events.loc[events.city == "", "reason"] = "missing_city"
    events["normalized"] = (events.city != raw.city) | (events.kind != raw.kind)
    accepted = events[events.reason == ""]
    quarantine = events[events.reason != ""]
    counts = accepted[accepted.kind == "click"].groupby("city").size().sort_index()
    with sqlite3.connect(":memory:") as db:
        events.to_sql("events", db, index=False)
        rows = db.execute("SELECT city, COUNT(*) FROM events WHERE reason='' AND kind='click' GROUP BY city ORDER BY city").fetchall()
    assert rows == list(counts.items())
    assert len(raw) == len(accepted) + len(quarantine)
    print("raw/accepted/quarantine:", len(raw), len(accepted), len(quarantine))
    print("reasons:", quarantine.reason.value_counts().sort_index().to_dict())
    print("normalized accepted:", int(accepted.normalized.sum()))
    print("clicks SQL and dataframe:", dict(rows))
    rides = pd.read_csv(DATA / "rides.csv")
    drivers = pd.read_csv(DATA / "drivers.csv")
    unmatched = rides[~rides.driver_id.isin(drivers.driver_id)]
    print("unmatched ride IDs:", unmatched.ride_id.tolist())
    assert unmatched.ride_id.tolist() == [6]
    core = pd.read_csv(DATA / "rides_core.csv")
    print("core city counts:", core.city.value_counts().sort_index().to_dict())
    print("core completed:", int((core.status == "completed").sum()))

def supervised():
    data = pd.read_csv(DATA / "ride_history.csv", parse_dates=["day"]).sort_values("day")
    train, valid, test = data.iloc[:360], data.iloc[360:480], data.iloc[480:]
    features = ["distance_km", "hour", "rain"]
    x_train, x_valid, x_test = (d[features] for d in (train, valid, test))
    model = make_pipeline(StandardScaler(with_mean=False), LogisticRegression(max_iter=500))
    model.fit(x_train, train.cancelled)
    pv = model.predict_proba(x_valid)[:, 1]
    print("train/validation/test", len(train), len(valid), len(test))
    print("validation ROC-AUC:", round(roc_auc_score(valid.cancelled, pv), 4))
    def stats(y, prob, threshold):
        tn, fp, fn, tp = confusion_matrix(y, prob >= threshold, labels=[0, 1]).ravel()
        return {"TP":int(tp), "FP":int(fp), "FN":int(fn), "TN":int(tn),
                "cost":int(fp + 4*fn), "precision":round(float(tp/max(1,tp+fp)),4), "recall":round(float(tp/max(1,tp+fn)),4)}
    threshold = min([.15,.2,.25,.3,.4,.5,.6], key=lambda t:stats(valid.cancelled,pv,t)["cost"])
    print("threshold chosen on validation", threshold, stats(valid.cancelled,pv,threshold))
    print("final held-out test:", stats(test.cancelled,model.predict_proba(x_test)[:,1],threshold))
    print("test all-negative baseline cost:", int(4*test.cancelled.sum()))
    reg = make_pipeline(StandardScaler(with_mean=False), LinearRegression())
    reg.fit(x_train, train.duration_min)
    print("test MAE regression:", round(mean_absolute_error(test.duration_min,reg.predict(x_test)),3))
    print("test MAE mean baseline:", round(mean_absolute_error(test.duration_min,[train.duration_min.mean()]*len(test)),3))

def cluster():
    data = pd.read_csv(DATA / "visits.csv")
    assert len(data)==900
    x = StandardScaler(with_mean=False).fit_transform(data[["pages","hour"]])
    print("features:", data[["pages","hour"]].describe().round(2).to_string())
    results = {}
    for k in (3,8):
        for seed in (7,8):
            labels = KMeans(n_clusters=k, random_state=seed, n_init=1).fit_predict(x)
            results[k,seed] = labels
            summary = data.assign(cluster=labels).groupby("cluster").agg(
                size=("visit_id","size"),avg_pages=("pages","mean"),avg_hour=("hour","mean"),
                conversion=("converted","mean")).sort_values(["avg_pages","avg_hour"])
            print(f"k={k} seed={seed}\n{summary.round(3).to_string()}")
        print(f"k={k} ARI:",round(adjusted_rand_score(results[k,7],results[k,8]),4))

if __name__ == "__main__":
    quality()
    supervised()
    cluster()
