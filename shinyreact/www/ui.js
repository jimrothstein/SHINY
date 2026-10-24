const { React, ReactDOM, useShinyInput, useShinyOutputValue,
        useShinyOutputStatus, useShinyOutputError, useShinyInitialized,
        useShinyBusy } = window.shinyreact;
const h = React.createElement;

function Histogram({ data }) {
  const breaks = data.breaks;
  const counts = data.counts;
  const n = counts.length;
  const min = breaks[0];
  const max = breaks[breaks.length - 1];
  const maxCount = Math.max(1, ...counts);
  const W = 560;
  const H = 260;
  const padL = 36;
  const padB = 28;
  const plotW = W - padL - 8;
  const plotH = H - padB - 8;
  const barW = plotW / n;

  return h(
    "svg",
    { viewBox: `0 0 ${W} ${H}`, width: "100%", height: "auto", role: "img",
      "aria-label": "Histogram of waiting times" },
    // bars
    ...counts.map((c, i) => {
      const bh = (c / maxCount) * plotH;
      return h("rect", {
        key: i,
        x: padL + i * barW + 1,
        y: 8 + (plotH - bh),
        width: Math.max(1, barW - 2),
        height: bh,
        fill: "#4682b4",
      });
    }),
    // baseline
    h("line", { x1: padL, y1: 8 + plotH, x2: padL + plotW, y2: 8 + plotH,
      stroke: "#333", strokeWidth: 1 }),
    // x labels min/max
    h("text", { x: padL, y: H - 6, fontSize: 11, fill: "#555" },
      Math.round(min)),
    h("text", { x: padL + plotW, y: H - 6, fontSize: 11, fill: "#555",
      textAnchor: "end" }, Math.round(max)),
    h("text", { x: padL, y: 12, fontSize: 11, fill: "#555" }, maxCount),
  );
}

function App() {
  const initialized = useShinyInitialized();
  const busy = useShinyBusy();
  const [bins, setBins] = useShinyInput("bin_count", 9);
  const data = useShinyOutputValue("dist_data", null);
  const status = useShinyOutputStatus("dist_data");
  const error = useShinyOutputError("dist_data");

  if (!initialized) return null;

  const recalculating = status === "recalculating";

  return h(
    "div",
    { className: busy ? "app busy" : "app" },
    h("h2", null, "Old Faithful — waiting times"),
    h("div", { className: "controls" },
      h("label", { htmlFor: "bins" }, "Bins: ", bins),
      h("input", {
        id: "bins",
        type: "range",
        min: 1,
        max: 50,
        value: bins,
        onChange: (e) => setBins(Number(e.target.value)),
      }),
    ),
    error
      ? h("div", { className: "shiny-output-error" }, error.message)
      : (data
          ? h("div", { className: recalculating ? "chart recalculating" : "chart" },
              h(Histogram, { data }))
          : h("div", { className: "skeleton" }, "Loading…")),
  );
}

const root = ReactDOM.createRoot(
  document.body.appendChild(document.createElement("div")),
);
root.render(h(App));
