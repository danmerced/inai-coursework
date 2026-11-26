from common import *
spark = session("quality-etl")
try:
    raw, accepted, quarantine = quality(spark)
    accepted.write.mode("overwrite").parquet(str(OUT / "accepted"))
    quarantine.write.mode("overwrite").parquet(str(OUT / "quarantine"))
    print("reconciliation", raw.count(), accepted.count(), quarantine.count())
    quarantine.groupBy("reason").count().show()
    accepted.filter("normalized").show()
finally:
    spark.stop()
