from shiny.express import input

from shinyreact import reactive_output, set_react_page

set_react_page()


@reactive_output
def greeting():
    return {"message": f"Hello, {input.name()}"}