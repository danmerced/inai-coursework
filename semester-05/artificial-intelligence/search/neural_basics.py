import numpy as np
from sklearn.neural_network import MLPClassifier
from sklearn.metrics import confusion_matrix, classification_report
from sklearn.datasets import make_classification
from sklearn.model_selection import train_test_split
from sklearn.pipeline import make_pipeline
from sklearn.preprocessing import StandardScaler

# Dense classification, trained and evaluated on independent synthetic rows.
x, y = make_classification(n_samples=800, n_features=6, n_informative=4,
                           n_redundant=0, random_state=42)
x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=.25, stratify=y, random_state=7)
model = make_pipeline(StandardScaler(), MLPClassifier(hidden_layer_sizes=(12,), max_iter=1500, random_state=7))
model.fit(x_train, y_train)
pred = model.predict(x_test)
print("Confusion matrix [[TN, FP], [FN, TP]]:\n", confusion_matrix(y_test, pred))
print(classification_report(y_test, pred, digits=3))
# CNN forward step: convolution-like cross-correlation with a vertical edge kernel.
image = np.array([[0,0,1,1],[0,0,1,1],[0,0,1,1],[0,0,1,1]], dtype=float)
kernel = np.array([[-1,1],[-1,1]])
feature_map = np.array([[np.sum(image[i:i+2,j:j+2]*kernel) for j in range(3)] for i in range(3)])
print("CNN feature map:\n", feature_map)
# One recurrent cell with shared weights, evaluated over a short sequence.
state = 0.0
for value in [0.2,0.5,0.8,0.1]:
    state = np.tanh(0.7*state + 0.9*value)
    print("RNN hidden state:", round(float(state),4))
