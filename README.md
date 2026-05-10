# FretboardChartCalculator

To start locally:

  * Run `mix setup` to install and setup dependencies
  * Run `mix assets.deploy` to install assets for local run
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Possible improvements

* Allow the user to switch between Guitar, Bass, Ukulele, or Mandolin.
* Use the Web Audio API to allow users to "hear" the scale or chord they have just generated.
* Add a button to "Shift Up/Down" the entire scale. This is a common workflow for musicians trying to change keys quickly.
* Allow users to download their current chart as an SVG or PNG. This is great for teachers or students who want to save their practice patterns.
