from ml_common import *
from pyspark.ml.functions import vector_to_array

def measures(frame, threshold):
    predicted = frame.withColumn("guess", (vector_to_array("probability")[1] >= threshold).cast("int"))
    tp, fp, fn, tn = [predicted.filter((F.col("guess")==g)&(F.col("cancelled")==y)).count()
                      for g,y in [(1,1),(1,0),(0,1),(0,0)]]
    return {"tp":tp,"fp":fp,"fn":fn,"tn":tn,"cost":fp+4*fn,
            "precision": tp/(tp+fp) if tp+fp else 0, "recall":tp/(tp+fn) if tp+fn else 0}

spark=session("supervised")
try:
    train, valid, test = split(spark)
    model=classifier(train)
    validation=model.transform(valid).cache()
    threshold=min([.15,.2,.25,.3,.4,.5,.6],key=lambda t:measures(validation,t)["cost"])
    print("Selected from validation only", threshold, measures(validation,threshold))
    print("Final test", measures(model.transform(test),threshold))
    print("All-negative baseline cost on test",4*test.filter("cancelled=1").count())
    reg=regressor(train)
    regression=reg.transform(test)
    mean=train.agg(F.avg("duration_min")).first()[0]
    regression.select(F.avg(F.abs(F.col("prediction")-F.col("duration_min"))).alias("model_mae"),
        F.avg(F.abs(F.lit(mean)-F.col("duration_min"))).alias("mean_baseline_mae")).show()
    validation.unpersist()
finally:
    spark.stop()
