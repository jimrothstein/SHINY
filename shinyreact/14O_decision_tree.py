# 14O_decision_tree.py
# USAGE:
# cd <this dir>
# source .venv/bin/activate
# python 14O_decision_tree.py

import pandas as pd
from sklearn.datasets import load_iris

iris = load_iris()
df = pd.DataFrame(iris.data, columns=iris.feature_names)
df["species"] = [iris.target_names[t] for t in iris.target]

print(df.to_string(index=False))
