defmodule FretboardChartCalculatorWeb.FretboardLive do
  use FretboardChartCalculatorWeb, :live_view
  require Logger

  alias FretboardChartCalculator.Calculator
  alias FretboardChartCalculator.Fretboard

  def mount(_params, _session, socket) do
    current_chart = Calculator.create_scale_chart("c♮", "natural_major")

    socket =
      socket
      |> assign(:scales, Calculator.scales)
      |> assign(:chords, Calculator.chords)
      |> assign(:current_mode, :scales)
      |> assign(:current_scale, "natural_major")
      |> assign(:current_chord, "major_triad")
      |> assign(:roots, Calculator.roots)
      |> assign(:current_root, "c")
      |> assign(:accidentals, Calculator.accidentals)
      |> assign(:current_accidental, "♮")
      |> assign(:string_ys, Fretboard.string_ys)
      |> assign(:fret_y1, Fretboard.fret_y1)
      |> assign(:fret_y2, Fretboard.fret_y2)
      |> assign(:fret_xs, Fretboard.fret_xs)
      |> assign(:marker_coords, Fretboard.marker_coords)
      |> assign(:note_xs, Fretboard.note_xs)
      |> assign(:string_data, Fretboard.string_data)
      |> assign(:string_x1, Fretboard.string_x1)
      |> assign(:string_x2, Fretboard.string_x2)
      |> assign(:fret_number_data, Fretboard.fret_number_data)
      |> assign(:fret_number_y, Fretboard.fret_number_y)
      |> assign(:neck, Fretboard.neck)
      |> assign(:nut, Fretboard.nut)
      |> assign(:fretboard, Fretboard.fretboard)
      |> assign(:current_chart, current_chart)

    {:ok, socket}
  end

  def handle_event("set-root-note-name", %{"value" => root_note_name}, socket) do
    socket =
      socket
      |> assign(:current_root, root_note_name)
      |> update_layout()
    {:noreply, socket}
  end

  def handle_event("set-root-note-accidental", %{"value" => accidental}, socket) do
    socket =
      socket
      |> assign(:current_accidental, accidental)
      |> update_layout()
    {:noreply, socket}
  end

  def handle_event("set-scale", %{"value" => scale}, socket) do
    socket =
      socket
      |> assign(:current_scale, scale)
      |> update_layout()
    {:noreply, socket}
  end

  def handle_event("set-chord", %{"value" => chord}, socket) do
    socket =
      socket
      |> assign(:current_chord, chord)
      |> update_layout()
    {:noreply, socket}
  end

  def handle_event("switch-to-scales", %{}, socket) do
    socket =
      socket
      |> assign(:current_mode, :scales)
      |> update_layout()
    {:noreply, socket}
  end

  def handle_event("switch-to-arpeggios", %{}, socket) do
    socket =
      socket
      |> assign(:current_mode, :arpeggios)
      |> update_layout()
    {:noreply, socket}
  end

  def handle_event(event, _params, socket) do
    event_str = inspect(event)
    Logger.warning("Unknown event #{event_str}")
    {:noreply, socket}
  end

  def update_layout(socket) do
    note = socket.assigns.current_root <> socket.assigns.current_accidental
    case socket.assigns.current_mode do
      :scales ->
        string_chart =
          Calculator.create_scale_chart(note,
                                        socket.assigns.current_scale)
        assign(socket, :current_chart, string_chart)
      :arpeggios ->
        string_chart =
          Calculator.create_arpeggio_chart(note,
                                           socket.assigns.current_chord)
        assign(socket, :current_chart, string_chart)
    end
  end
end
