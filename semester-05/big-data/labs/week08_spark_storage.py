from common import *
spark = session("storage")
try:
    _, accepted, _ = quality(spark)
    path = str(OUT / "events_by_city")
    accepted.select("event_id", "city", "kind", "event_time").write.mode("overwrite").partitionBy("city").parquet(path)
    data = spark.read.parquet(path)
    data.groupBy("city").count().orderBy("city").show()
    selected = data.filter(F.col("city") == "Tashkent")
    selected.show()
    selected.explain("formatted")
finally:
    spark.stop()
