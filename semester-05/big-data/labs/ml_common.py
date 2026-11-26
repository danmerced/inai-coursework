from common import *
from pyspark.ml import Pipeline
from pyspark.ml.feature import VectorAssembler, StandardScaler
from pyspark.ml.classification import LogisticRegression
from pyspark.ml.regression import LinearRegression

def split(spark):
    data = spark.read.option("header", True).schema(
        "ride_id INT, day DATE, distance_km DOUBLE, hour DOUBLE, rain INT, cancelled INT, duration_min DOUBLE"
    ).csv(str(DATA / "ride_history.csv"))
    # One chronological row per day. Boundaries fixed before model training.
    return (data.filter("ride_id<=360"), data.filter("ride_id>360 AND ride_id<=480"), data.filter("ride_id>480"))

def classifier(train):
    return Pipeline(stages=[VectorAssembler(inputCols=["distance_km","hour","rain"],outputCol="raw_features"),
        StandardScaler(inputCol="raw_features", outputCol="features",withMean=False),
        LogisticRegression(featuresCol="features",labelCol="cancelled",maxIter=40)]).fit(train)

def regressor(train):
    return Pipeline(stages=[VectorAssembler(inputCols=["distance_km","hour","rain"],outputCol="raw_features"),
        StandardScaler(inputCol="raw_features",outputCol="features",withMean=False),
        LinearRegression(featuresCol="features",labelCol="duration_min")]).fit(train)
