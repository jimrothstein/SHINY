import sys
from pathlib import Path

EXAMPLE = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(EXAMPLE))

from faithful import histogram, load_waiting


def test_load_waiting_shape():
    w = load_waiting()
    assert w.shape == (272,)
    assert w.min() > 40 and w.max() < 100


def test_histogram_breaks_counts():
    w = load_waiting()
    out = histogram(w, 9)
    assert len(out["breaks"]) == 10
    assert len(out["counts"]) == 9
    assert sum(out["counts"]) == 272


def test_histogram_one_bin():
    w = load_waiting()
    out = histogram(w, 1)
    assert len(out["breaks"]) == 2
    assert len(out["counts"]) == 1
    assert out["counts"][0] == 272


def test_histogram_bins_50():
    w = load_waiting()
    out = histogram(w, 50)
    assert len(out["breaks"]) == 51
    assert len(out["counts"]) == 50
    assert sum(out["counts"]) == 272
