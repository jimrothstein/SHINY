const { React, ReactDOM, useShinyInput, useShinyOutputValue } = window.shinyreact;
const h = React.createElement;

function App() {
  const [name, setName] = useShinyInput("name", "world");
  const greeting = useShinyOutputValue("greeting", { message: "" });

  return h(
    "div",
    null,
    h("h2", null, "Hello Shiny React"),
    h("input", {
      type: "text",
      value: name,
      onChange: (e) => setName(e.target.value),
    }),
    h("p", null, greeting && greeting.message ? greeting.message : "Loading…"),
  );
}

const root = ReactDOM.createRoot(
  document.body.appendChild(document.createElement("div")),
);
root.render(h(App));
