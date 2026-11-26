from common import *
spark = session("partitions")
try:
    data = rides(spark, core=True)
    for frame in [data.coalesce(1), data.repartition(4, "city")]:
        print("Partitions:", frame.rdd.getNumPartitions())
        frame.groupBy(F.spark_partition_id().alias("partition")).count().show()
        frame.groupBy("city").count().orderBy("city").show()
        frame.groupBy("city").count().explain()
finally:
    spark.stop()
