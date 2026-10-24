from shiny import reactive
from shiny.express import input
from shinyreact import reactive_output, set_react_page

set_react_page()

sales = load_sales()  # long-format fact table: date, region, revenue


@reactive.calc
def filtered():
    return sales[sales.region.isin(input.regions())]


@reactive_output
def summary():
    df = filtered()
    by_month = df.groupby(df.date.dt.to_period("M")).revenue.sum()
    return {
        "n": int(len(df)),
        "total": float(df.revenue.sum()),
        "series": [{"month": str(m), "revenue": float(v)} for m, v in by_month.items()],
        "rows": df.head(50).to_dict(orient="records"),
    }