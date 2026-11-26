"""Offline research exercise on a locally authorized HAM10000 copy."""
import argparse
from pathlib import Path
import json
import pandas as pd
import numpy as np
from sklearn.model_selection import StratifiedGroupKFold
from sklearn.metrics import confusion_matrix, classification_report

LABELS = ["bkl", "mel", "nv"]
SIZE = (96,96)

def prepare(meta, image_root):
    metadata = pd.read_csv(meta)
    files = {p.stem: str(p) for p in image_root.rglob("*.jpg")}
    df = metadata[metadata.dx.isin(LABELS)].copy()
    df["path"] = df.image_id.map(files)
    if df.path.isna().any():
        raise ValueError("Missing image files. Check the dataset directory.")
    if df.lesion_id.isna().any() or df.image_id.duplicated().any():
        raise ValueError("Missing lesion IDs or duplicate image IDs.")
    return df

def split_groups(df):
    # Lesions, not images, are kept independent across the three sets.
    outer = StratifiedGroupKFold(5, shuffle=True, random_state=7)
    remaining, test = next(outer.split(df, df.dx, df.lesion_id))
    pool = df.iloc[remaining].reset_index(drop=True)
    inner = StratifiedGroupKFold(4, shuffle=True, random_state=8)
    train, validation = next(inner.split(pool, pool.dx, pool.lesion_id))
    parts = [pool.iloc[train],pool.iloc[validation],df.iloc[test]]
    groups = [set(part.lesion_id) for part in parts]
    assert not (groups[0]&groups[1] or groups[0]&groups[2] or groups[1]&groups[2])
    return parts

def run(args):
    import tensorflow as tf
    tf.keras.utils.set_random_seed(7)
    df = prepare(args.metadata, args.images)
    train, valid, test = split_groups(df)
    print("Independent lesions:",
          [part.lesion_id.nunique() for part in (train,valid,test)])
    def batch(part, shuffle=False):
        paths = part.path.to_numpy(dtype=str)
        labels = part.dx.map({label:i for i,label in enumerate(LABELS)}).to_numpy()
        ds = tf.data.Dataset.from_tensor_slices((paths,labels))
        def load(path,label):
            image = tf.image.decode_jpeg(tf.io.read_file(path), channels=3)
            image = tf.image.resize(image,SIZE)
            return image, label
        if shuffle: ds = ds.shuffle(len(part), seed=7)
        return ds.map(load,num_parallel_calls=tf.data.AUTOTUNE).batch(32).prefetch(tf.data.AUTOTUNE)
    # Use pretrained weights only if they have been acquired from an authorized source;
    # weights=None permits an offline architecture demonstration.
    base = tf.keras.applications.MobileNetV2(include_top=False,
        weights=args.weights, input_shape=(*SIZE,3), pooling="avg")
    base.trainable = args.weights is None
    inputs = tf.keras.Input(shape=(*SIZE,3))
    x = tf.keras.applications.mobilenet_v2.preprocess_input(inputs)
    x = base(x)
    output = tf.keras.layers.Dense(len(LABELS),activation="softmax")(x)
    model = tf.keras.Model(inputs,output)
    model.compile(optimizer="adam", loss="sparse_categorical_crossentropy", metrics=["accuracy"])
    model.fit(batch(train,True), validation_data=batch(valid), epochs=args.epochs,
              callbacks=[tf.keras.callbacks.EarlyStopping(patience=2, restore_best_weights=True)])
    truth = test.dx.map({label:i for i,label in enumerate(LABELS)}).to_numpy()
    labels = model.predict(batch(test),verbose=0).argmax(axis=1)
    metrics = {"labels":LABELS, "majority_baseline_accuracy":float((truth==LABELS.index(train.dx.mode().iloc[0])).mean()),"confusion_matrix":confusion_matrix(truth,labels,labels=range(3)).tolist(),
        "report":classification_report(truth,labels,labels=range(3),target_names=LABELS,output_dict=True,zero_division=0)}
    args.output.mkdir(parents=True,exist_ok=True)
    (args.output/"metrics.json").write_text(json.dumps(metrics,indent=2))
    pd.DataFrame({"image_id":test.image_id.to_numpy(), "true_class":test.dx.to_numpy(),
        "predicted_class":[LABELS[i] for i in labels]}).to_csv(args.output/"predictions.csv", index=False)
    model.save(args.output/"educational_model.keras")
    print(json.dumps(metrics,indent=2))

if __name__ == "__main__":
    p=argparse.ArgumentParser()
    p.add_argument("--metadata",type=Path,required=True)
    p.add_argument("--images",type=Path,required=True)
    p.add_argument("--weights",default=None,help="Local MobileNetV2 weights, or imagenet if download is available")
    p.add_argument("--epochs",type=int,default=5)
    p.add_argument("--output",type=Path,default=Path("output"))
    run(p.parse_args())
