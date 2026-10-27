# 130_shinyexpress_faithful.py
# UI is written by LLM and in js. Done for me!
import numpy as np
from shiny.express import input
from shinyreact import reactive_output, set_react_page

from faithful import load_waiting, histogram

set_react_page()

waiting = load_waiting()


@reactive_output
def dist_data():
    bins = input.bin_count()
    if bins is None:
        return None
    return histogram(waiting, bins)
