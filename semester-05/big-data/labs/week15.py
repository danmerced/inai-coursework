from common import *
from pyspark.ml import Pipeline
from pyspark.ml.feature import VectorAssembler, StandardScaler
from pyspark.ml.clustering import KMeans
from sklearn.metrics import adjusted_rand_score

spark = session("visit-clustering")
try:
    data = spark.read.option("header", True).schema("visit_id INT, pages DOUBLE, hour DOUBLE, converted INT").csv(str(DATA / "visits.csv"))
    assert data.count() == 900
    data.select("pages", "hour").describe().show()
    labels = {}
    for k in (3, 8):
        for seed in (7, 8):
            pipeline = Pipeline(stages=[
                VectorAssembler(inputCols=["pages", "hour"], outputCol="raw_features"),
                StandardScaler(inputCol="raw_features", outputCol="features", withMean=False),
                KMeans(k=k, seed=seed, featuresCol="features")
            ])
            model = pipeline.fit(data)
            result = model.transform(data)
            print("k =", k, "seed =", seed)
            result.groupBy("prediction").agg(F.count("*").alias("size"), F.avg("pages").alias("avg_pages"),
                F.avg("hour").alias("avg_hour"), F.avg("converted").alias("converted_rate")).orderBy("avg_pages", "avg_hour").show()
            labels[k, seed] = [r.prediction for r in result.orderBy("visit_id").select("prediction").collect()]
        print("Label-permutation invariant ARI", k, adjusted_rand_score(labels[k,7],labels[k,8]))
finally:
    spark.stop()
