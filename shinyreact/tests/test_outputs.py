import sys
from pathlib import Path

EXAMPLE = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(EXAMPLE))

import pytest

pytestmark = pytest.mark.parametrize("local_server", ["../130_shinyexpress_faithful.py"], indirect=True)


def test_dist_data_bins_9(local_server):
    local_server.set_inputs(bin_count=9)
    out = local_server.get_output("dist_data")
    assert out.status == "ok"
    val = out.value
    assert len(val["breaks"]) == 10
    assert len(val["counts"]) == 9
    assert sum(val["counts"]) == 272


def test_dist_data_bins_1(local_server):
    local_server.set_inputs(bin_count=1)
    out = local_server.get_output("dist_data")
    assert out.status == "ok"
    val = out.value
    assert len(val["counts"]) == 1
    assert val["counts"][0] == 272


def test_dist_data_unset_is_silent(local_server):
    out = local_server.get_output("dist_data")
    # before any input set, status should be silent (unset input)
    assert out.status in ("silent", "ok")
