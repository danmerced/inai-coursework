from common import *
spark = session("provenance")
try:
    frame = rides(spark).withColumn("source_file", F.input_file_name()).withColumn("ingested_at", F.current_timestamp())
    frame.write.mode("overwrite").parquet(str(OUT / "ride_baseline"))
    frame.groupBy("city").agg(F.count("*").alias("rides"), F.sum("fare").alias("total_fare")).show()
    frame.select("ride_id", "source_file", "ingested_at").show(truncate=False)
finally:
    spark.stop()
