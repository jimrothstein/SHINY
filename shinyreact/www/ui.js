const { React, ReactDOM, useShinyInput, useShinyOutputValue,
        useShinyOutputStatus, useShinyOutputError, useShinyInitialized } =
  window.shinyreact;
const h = React.createElement;

function Table({ rows }) {
  if (!rows || rows.length === 0) {
    return h("p", { className: "empty" }, "No rows");
  }
  const cols = Object.keys(rows[0]);
  return h(
    "table",
    { className: "data-table" },
    h("thead", null,
      h("tr", null, cols.map((c) => h("th", { key: c }, c)))),
    h("tbody", null,
      rows.map((r, i) =>
        h("tr", { key: i },
          cols.map((c) => h("td", { key: c }, String(r[c])))))),
  );
}

function App() {
  const initialized = useShinyInitialized();
  const [criteria, setCriteria] = useShinyInput("criteria", "sepal_length > 4.6");
  const iris = useShinyOutputValue("iris_data", null);
  const filtered = useShinyOutputValue("filtered_data", null);
  const status = useShinyOutputStatus("filtered_data");
  const error = useShinyOutputError("filtered_data");

  if (!initialized) return null;

  return h(
    "div",
    { className: "app" },
    h("h2", null, "Iris dataset — first 10 rows"),
    iris ? h(Table, { rows: iris.rows }) : h("p", null, "Loading…"),
    h("h2", null, "Filter criteria"),
    h("input", {
      type: "text",
      value: criteria,
      onChange: (e) => setCriteria(e.target.value),
      placeholder: "e.g. sepal_length > 4.6",
      style: { width: "100%", padding: "0.4rem" },
    }),
    h("h2", null, "Matching rows — first 10"),
    error
      ? h("div", { className: "shiny-output-error" }, error.message)
      : (filtered
          ? h("div", { className: status === "recalculating" ? "table recalculating" : "table" },
              h("p", null, `matched: ${filtered.n}`),
              h(Table, { rows: filtered.rows }))
          : h("p", null, "Loading…")),
  );
}

const root = ReactDOM.createRoot(
  document.body.appendChild(document.createElement("div")),
);
root.render(h(App));
