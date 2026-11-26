"""A read-only educational metrics viewer, not a patient-facing classifier."""
import json
from pathlib import Path
import streamlit as st
import pandas as pd

st.title("Skin Disease Classification — research demo")
st.warning("Educational dataset evaluation only. Not suitable for diagnosis, clinical screening or treatment decisions.")
path = Path("output/metrics.json")
if not path.exists():
    st.info("Run train.py on an authorized research dataset first. No clinical metrics are available yet.")
else:
    metrics=json.loads(path.read_text())
    st.write("Dataset class codes:", metrics["labels"])
    st.subheader("Held-out confusion matrix")
    st.dataframe(metrics["confusion_matrix"])
    st.subheader("Classification report")
    st.json(metrics["report"])

    predictions = Path("output/predictions.csv")
    if predictions.exists():
        samples = pd.read_csv(predictions)
        st.subheader("Held-out dataset examples")
        image_id = st.selectbox("Select an evaluated dataset entry", samples.image_id.tolist())
        sample = samples[samples.image_id == image_id].iloc[0]
        st.write("Reference label:", sample.true_class)
        st.write("Model label:", sample.predicted_class)
        st.caption("Recorded research-set prediction only, not a patient assessment.")
