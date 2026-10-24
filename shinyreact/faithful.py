# faithful.py — pure logic for the Old Faithful waiting-time histogram.
import numpy as np
import pandas as pd
from pathlib import Path

HERE = Path(__file__).resolve().parent
DATA_PATH = HERE / "faithful.csv"


def load_waiting(path=None):
    p = Path(path) if path is not None else DATA_PATH
    df = pd.read_csv(p)
    return df["waiting"].to_numpy()


def histogram(waiting, bins):
    """Equal-width histogram of `waiting` into `bins` bins.

    Returns {"breaks": [...], "counts": [...]} with len(breaks)==bins+1.
    """
    bins = int(bins)
    if bins < 1:
        raise ValueError("bins must be >= 1")
    breaks = np.linspace(float(np.min(waiting)), float(np.max(waiting)), bins + 1)
    counts, _ = np.histogram(waiting, bins=breaks)
    return {"breaks": [float(b) for b in breaks], "counts": [int(c) for c in counts]}
