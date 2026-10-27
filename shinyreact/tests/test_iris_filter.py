import sys
from pathlib import Path

EXAMPLE = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(EXAMPLE))

import pytest

pytestmark = pytest.mark.parametrize("local_server", ["../150_iris_filter.py"], indirect=True)


def test_iris_first_10(local_server):
    out = local_server.get_output("iris_data")
    assert out.status == "ok"
    val = out.value
    assert len(val["rows"]) == 10
    assert val["n"] == 150
    assert val["rows"][0]["species"] in ("setosa", "versicolor", "virginica")


def test_filtered_default_criteria(local_server):
    local_server.set_inputs(criteria="sepal_length > 4.6")
    out = local_server.get_output("filtered_data")
    assert out.status == "ok"
    val = out.value
    assert len(val["rows"]) == 10
    assert val["n"] > 10
    assert all(r["sepal_length"] > 4.6 for r in val["rows"])


def test_filtered_empty_criteria(local_server):
    local_server.set_inputs(criteria="")
    out = local_server.get_output("filtered_data")
    assert out.status == "ok"
    assert out.value["n"] == 150
    assert len(out.value["rows"]) == 10


def test_filtered_invalid_criteria(local_server):
    local_server.set_inputs(criteria="sepal_length >>> 4.6")
    out = local_server.get_output("filtered_data")
    assert out.status in ("error", "silent")
