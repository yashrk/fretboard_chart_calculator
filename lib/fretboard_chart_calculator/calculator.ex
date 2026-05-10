defmodule FretboardChartCalculator.Calculator do
  @type note :: String.t()
  @type accidental :: String.t()
  @type scale_name :: String.t()
  @type chord_name :: String.t()
  @type scale_or_chord :: atom()
  @type string_number :: pos_integer()
  @type fret :: non_neg_integer()
  @type string_chart :: [{fret(), note()}]
  @type chart :: %{string_number() => string_chart()}

  @spec roots() :: [{note(), note()}]
  def roots do
    [
      {"A", "a"},
      {"B", "b"},
      {"H", "h"},
      {"C", "c"},
      {"D", "d"},
      {"E", "e"},
      {"F", "f"},
      {"G", "g"}
    ]
  end

  @spec accidentals() :: [{accidental(), accidental()}]
  def accidentals do
    [{"♭", "♭"}, {"♮", "♮"}, {"♯", "♯"}]
  end

  @spec scales() :: [{String.t(), scale_or_chord()}]
  def scales do
    for({{:scale, s}, descr} <- :music_scale.known_scales(), do: {descr, s})
  end

  @spec chords() :: [{String.t(), scale_or_chord()}]
  def chords do
    for({{:chord, c}, descr} <- :music_scale.known_chords(), do: {descr, c})
  end

  @spec create_scale_chart(note(), scale_name()) :: chart()
  def create_scale_chart(note, scale) do
    fretboard = :music_scale.standard_guitar_fretboard()
    scale = String.to_existing_atom(scale)

    {:chart, string_charts_list} =
      :music_scale.chart_for_scale(
        fretboard,
        {:scale, scale},
        note
      )

    chart_to_map(string_charts_list)
  end

  @spec create_arpeggio_chart(note(), chord_name()) :: chart()
  def create_arpeggio_chart(note, chord) do
    fretboard = :music_scale.standard_guitar_fretboard()
    chord = String.to_existing_atom(chord)

    {:chart, string_charts_list} =
      :music_scale.chart_for_arpeggio(
        fretboard,
        {:chord, chord},
        note
      )

    chart_to_map(string_charts_list)
  end

  @spec chart_to_map(any()) :: chart()
  def chart_to_map(string_charts_list) do
    for {{:mus_string, string_number, _note}, string_chart} <- string_charts_list do
      {string_number, string_chart}
    end
    |> Map.new()
  end
end
