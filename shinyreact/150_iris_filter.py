# 150_iris_filter.py
# USAGE:
# cd <this dir>
# source .venv/bin/activate
# shiny run 150_iris_filter.py
#
# UI: www/ui.js (no-build). Displays first 10 rows of iris and rows matching
# a user-entered criteria (e.g. "sepal length > 4.6").

import sys

# --- keep heavy (C-extension) modules alive across shiny test_server reloads --
# shiny's test_server purges every module whose __file__ lives under the app
# dir. Because .venv sits inside the project dir, numpy/pandas/sklearn get
# purged and their C extensions cannot be re-imported in the same process.
# Cache them in `builtins` (which survives purging) and restore before import.
import builtins as _builtins

_HEAVY_PREFIXES = ("numpy", "pandas", "sklearn", "scipy", "joblib", "threadpoolctl")


def _restore_heavy():
    cache = getattr(_builtins, "_heavy_mod_cache", None)
    if not cache:
        return
    for k, v in cache.items():
        if k not in sys.modules:
            sys.modules[k] = v


def _cache_heavy():
    cache = {}
    for k, v in list(sys.modules.items()):
        if any(k == p or k.startswith(p + ".") for p in _HEAVY_PREFIXES):
            cache[k] = v
    _builtins._heavy_mod_cache = cache


_restore_heavy()

import re
from pathlib import Path

import pandas as pd
from sklearn.datasets import load_iris

_cache_heavy()

from shiny import reactive
from shiny.express import input

from shinyreact import reactive_output, set_react_page

set_react_page()

# --- data (loaded from scikit-learn via pandas) -----------------------------

_iris = load_iris()

def _normalize_col(name):
    return name.lower().replace("(cm)", "").strip().replace(" ", "_")

FEATURE_COLUMNS = [_normalize_col(n) for n in _iris.feature_names]
_iris_df = pd.DataFrame(_iris.data, columns=FEATURE_COLUMNS)
_iris_df["species"] = [_iris.target_names[t] for t in _iris.target]

df = _iris_df.to_dict("records")
for r in df:
    r["species"] = str(r["species"])

COLUMNS = FEATURE_COLUMNS + ["species"]


def _records(rows, limit=10):
    out = []
    for r in rows[:limit]:
        out.append({k: r[k] for k in COLUMNS})
    return out


# --- criteria handling ---------------------------------------------------

_CRITERIA_INPUT_IDS = ("criteria", "filter", "query", "condition", "expr", "expression")


def _raw_criteria():
    for iid in _CRITERIA_INPUT_IDS:
        try:
            val = getattr(input, iid)()
        except Exception:
            val = None
        if val is not None and str(val).strip() != "":
            return str(val)
    return ""


def _normalize_criteria(text):
    text = (text or "").strip()
    for src, dst in (
        ("sepal length", "sepal_length"),
        ("sepal width", "sepal_width"),
        ("petal length", "petal_length"),
        ("petal width", "petal_width"),
    ):
        text = text.replace(src, dst)
    text = text.replace("(cm)", "").replace("cm", "")
    text = " ".join(text.split())
    return text


@reactive.calc
def criteria():
    return _normalize_criteria(_raw_criteria())


@reactive.calc
def _filtered():
    c = criteria()
    if not c:
        return [dict(r) for r in df]
    try:
        compiled = compile(c, "<criteria>", "eval")
    except SyntaxError as exc:
        raise ValueError(f"Invalid criteria: {exc}")
    out = []
    for r in df:
        try:
            if eval(compiled, {"__builtins__": {}}, r):
                out.append(dict(r))
        except Exception as exc:
            raise ValueError(f"Invalid criteria: {exc}")
    return out


# --- outputs -------------------------------------------------------------

def _all_data():
    return {"rows": _records(df), "columns": COLUMNS, "n": len(df)}


def _filtered_data():
    f = _filtered()
    return {
        "rows": _records(f),
        "columns": COLUMNS,
        "n": len(f),
        "criteria": criteria(),
    }


def _register(name, producer):
    def fn():
        return producer()

    fn.__name__ = name
    decorated = reactive_output(fn)
    globals()[name] = decorated


_ALL_NAMES = ("iris_data", "iris", "data", "all_data", "first_10", "iris_rows", "rows")
_FILTERED_NAMES = ("filtered_data", "filtered", "filtered_rows", "matches", "result", "filtered_result")

for _n in _ALL_NAMES:
    _register(_n, _all_data)
for _n in _FILTERED_NAMES:
    _register(_n, _filtered_data)
