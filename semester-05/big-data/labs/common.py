from pathlib import Path
from pyspark.sql import SparkSession, functions as F, types as T

ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT / "data"
OUT = ROOT / "output"

def session(name):
    OUT.mkdir(exist_ok=True)
    spark = (SparkSession.builder.master("local[2]").appName(name)
             .config("spark.sql.shuffle.partitions", "4")
             .config("spark.ui.enabled", "true")
             .getOrCreate())
    spark.sparkContext.setLogLevel("WARN")
    return spark

def rides(spark, core=False):
    schema = "ride_id INT, driver_id INT, city STRING, ride_date DATE, status STRING, fare DECIMAL(10,2)"
    return spark.read.option("header", True).schema(schema).csv(str(DATA / ("rides_core.csv" if core else "rides.csv")))

def quality(spark):
    raw = spark.read.option("header", True).schema(
        "event_id INT, city STRING, kind STRING, event_time TIMESTAMP"
    ).csv(str(DATA / "events_quality.csv"))
    city = F.initcap(F.lower(F.trim(F.col("city"))))
    kind = F.lower(F.trim(F.col("kind")))
    marked = (raw.withColumn("city_original", F.col("city"))
              .withColumn("kind_original", F.col("kind"))
              .withColumn("city", city).withColumn("kind", kind)
              .withColumn("reason", F.when(F.col("city").isNull() | (F.col("city") == ""), "missing_city")
                          .when(~F.coalesce(F.col("kind").isin("click", "view"), F.lit(False)), "unknown_kind"))
              .withColumn("normalized", ~F.col("city").eqNullSafe(F.col("city_original")) |
                          ~F.col("kind").eqNullSafe(F.col("kind_original"))))
    return raw, marked.filter("reason IS NULL"), marked.filter("reason IS NOT NULL")
