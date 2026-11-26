"""Validate an image classification pipeline using artificial geometrical patterns.
Classes are artificial textures, not real diseases."""
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.metrics import confusion_matrix, classification_report
from sklearn.linear_model import LogisticRegression

def dataset():
    rng = np.random.default_rng(7)
    yy, xx = np.mgrid[:24, :24]
    images, labels = [], []
    for i in range(450):
        label = i % 3
        cx,cy = rng.uniform(9,15,2)
        radius = rng.uniform(3,7)
        disk = (xx-cx)**2 + (yy-cy)**2 < radius**2
        if label==0: pattern=disk
        elif label==1: pattern=(np.sin(xx*1.3)>0)&disk
        else: pattern=(np.cos(yy*1.3)>0)&disk
        img=(pattern*0.7 + rng.normal(.15,.08,(24,24))).clip(0,1)
        images.append(img)
        labels.append(label)
    return np.array(images),np.array(labels)

def features(images):
    return np.column_stack([images.mean((1,2)),images.std((1,2)),
       np.abs(np.diff(images,axis=1)).mean((1,2)),np.abs(np.diff(images,axis=2)).mean((1,2))])

def main():
    x,y=dataset()
    xt,xv,yt,yv=train_test_split(features(x),y,test_size=.25,random_state=7,stratify=y)
    model=LogisticRegression(max_iter=500,C=15).fit(xt,yt)
    pred=model.predict(xv)
    print("Synthetic geometry only — not medical accuracy")
    print(confusion_matrix(yv,pred))
    print(classification_report(yv,pred,target_names=["disk","vertical stripes","horizontal stripes"],digits=3))

if __name__=="__main__":
    main()
