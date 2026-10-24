# Behavior — Old Faithful waiting-time histogram

- data: `faithful.csv`, column `waiting` (minutes, ~43–96); 272 rows. NOT `eruptions`.
- histogram: equal-width bins from min to max; breaks length = bins + 1.
- bins input:
  - id `bin_count`, integer, range 1–50, default 9
  - updates live (debounce default 100ms)
  - drives `dist_data`
- output `dist_data`: `{breaks: number[], counts: number[]}`.
- while recalculating: previous chart stays mounted and dims (no skeleton flash).
- before first value: show skeleton/loading.
- errors: show server error message in `.shiny-output-error`.
- first paint gated on `useShinyInitialized()`.
