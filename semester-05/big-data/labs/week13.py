from ml_common import *
from pyspark.ml.evaluation import BinaryClassificationEvaluator
spark = session("ml-pipeline")
try:
    train, validation, test = split(spark)
    print("train, validation, test", train.count(), validation.count(), test.count())
    model = classifier(train)
    pred = model.transform(validation)
    evaluator = BinaryClassificationEvaluator(labelCol="cancelled", metricName="areaUnderROC")
    print("Validation AUC", evaluator.evaluate(pred))
    baseline = train.agg(F.avg("cancelled")).first()[0]
    print("Train majority class", int(baseline >= .5))
    print("Validation majority accuracy", validation.filter(F.col("cancelled") == int(baseline >= .5)).count() / validation.count())
    # Test is reserved for final assessment, not tuning.
finally:
    spark.stop()
