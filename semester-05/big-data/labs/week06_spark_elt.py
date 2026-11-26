from common import *
spark = session("quality-elt")
try:
    raw, _, _ = quality(spark)
    raw.write.mode("overwrite").parquet(str(OUT / "raw"))
    spark.read.parquet(str(OUT / "raw")).createOrReplaceTempView("events_raw")
    mart = spark.sql("""
        SELECT initcap(lower(trim(city))) AS city, count(*) AS clicks
        FROM events_raw WHERE trim(city)<>'' AND city IS NOT NULL AND lower(trim(kind))='click'
        GROUP BY initcap(lower(trim(city))) ORDER BY city
    """)
    mart.show()
    mart.write.mode("overwrite").parquet(str(OUT / "city_clicks"))
finally:
    spark.stop()
