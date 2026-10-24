# shinyexpress_faithful.py
import numpy as np
import pandas as pd
from shiny.express import input
from shinyreact import reactive_output, set_react_page

# Set up the page UI using shinyreact (express)
set_react_page()

x = pd.read_csv("faithful.csv")["waiting"].to_numpy()


@reactive_output
def dist_data():
    breaks = np.linspace(x.min(), x.max(), input.bin_count() + 1)
    counts, _ = np.histogram(x, bins=breaks)
    return {"breaks": breaks.tolist(), "counts": counts.tolist()}