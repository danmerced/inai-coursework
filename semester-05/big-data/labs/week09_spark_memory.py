from common import *
from pyspark import StorageLevel
spark = session("cache")
try:
    path = str(OUT / "rides_disk")
    rides(spark, core=True).write.mode("overwrite").parquet(path)
    data = spark.read.parquet(path).persist(StorageLevel.MEMORY_AND_DISK)
    print("rows", data.count())
    data.filter("status='completed'").show()
    print("completed", data.filter("status='completed'").count())
    data.explain("formatted")
    print("storage level", data.storageLevel)
    data.unpersist(blocking=True)
    spark.catalog.clearCache()
    data = spark.read.parquet(path)
    print("read-back", data.count())
    data.explain("formatted")
finally:
    spark.stop()
