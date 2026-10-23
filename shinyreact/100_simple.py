# USAGE:
# cd <this dir>
# source .venv/bin/activate
# shiny run 100_simple.py

from shiny.express import input
from shinyreact import reactive_output, set_react_page

set_react_page()

@reactive_output
def greeting():
    val = input.name()
    print("GREETING CALLED, input.name() =", repr(val), flush=True)
    return {"message": f"Hello, {val}"}
