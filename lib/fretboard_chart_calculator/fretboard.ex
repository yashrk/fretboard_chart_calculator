defmodule FretboardChartCalculator.Fretboard do
  @type y_position :: non_neg_integer()
  @type thickness :: float()
  @type string_tuple :: {y_position(), thickness()}
  @type x_coordinate :: non_neg_integer()
  @type string_map :: %{pos_integer() => y_position()}
  @type fret_x :: float()
  @type fret_xs :: [fret_x()]
  @type roman_numeral :: String.t()
  @type fret_number_tuple :: {fret_x(), roman_numeral()}
  @type fret_number_data :: [fret_number_tuple()]
  @type note_x :: float()
  @type note_xs_map :: %{non_neg_integer() => note_x()}
  @type coord :: {float(), integer()}
  @type marker_coords :: [coord()]
  @type dimension :: non_neg_integer()
  @type neck_map :: %{x: dimension(), y: dimension(), width: dimension(), height: dimension(), rx: dimension()}
  @type nut_map :: %{x: dimension(), y: dimension(), width: dimension(), height: dimension()}
  @type fretboard_map :: %{x: dimension(), y: dimension(), width: dimension(), height: dimension(), rx: dimension()}

  @spec string_data() :: [string_tuple()]
  def string_data do
    # y, thickness
    [
      {120, 2.2},
      {100, 1.8},
      {80, 1.5},
      {60, 1.2},
      {40, 0.9},
      {20, 0.6}
    ]
  end

  @spec string_x1() :: x_coordinate()
  def string_x1, do: 5
  @spec string_x2() :: x_coordinate()
  def string_x2, do: 584

  @spec string_ys() :: string_map()
  def string_ys do
    Enum.zip(
      1..6,
      [20, 40, 60, 80, 100, 120]
    )
    |> Map.new()
  end

  @spec fret_y1() :: y_position()
  def fret_y1, do: 19
  @spec fret_y2() :: y_position()
  def fret_y2, do: 122

  @spec fretboard_center() :: non_neg_integer()
  def fretboard_center, do: div(fret_y1() + fret_y2(), 2)

  @spec fret_xs() :: fret_xs()
  def fret_xs do
    [
      140.13,
      193.10,
      243.10,
      290.30,
      334.85,
      376.89,
      416.58,
      454.04,
      489.40,
      522.77,
      554.27,
      584.00
    ]
  end

  @spec fret_roman_numbers() :: [roman_numeral()]
  def fret_roman_numbers do
    [
      "I",
      "II",
      "III",
      "IV",
      "V",
      "VI",
      "VII",
      "VIII",
      "IX",
      "X",
      "XI",
      "XII"
    ]
  end

  @spec fret_number_data() :: fret_number_data()
  def fret_number_data do
    Enum.zip(fret_xs(), fret_roman_numbers())
  end

  @spec fret_number_y() :: y_position()
  def fret_number_y, do: 138

  @spec note_xs() :: note_xs_map()
  def note_xs do
    Enum.zip([15, 80|fret_xs()], [80|fret_xs()])
    |> Enum.map(fn {a, b} -> (a+b)/2 end)
    |> then(&(Enum.zip(0..12, &1)))
    |> Map.new()
  end

  @spec marker_coords() :: marker_coords()
  def marker_coords do
    [
      {note_xs()[5], fretboard_center()},
      {note_xs()[7], fretboard_center()},
      {note_xs()[10], fretboard_center()},
      {note_xs()[12], 50},
      {note_xs()[12], 90}
    ]
  end

  @spec neck() :: neck_map()
  def neck do
    %{
      x: 0,
      y: 15,
      width: 76,
      height: 110,
      rx: 5
    }
  end

  @spec nut() :: nut_map()
  def nut do
    %{
      x: 76,
      y: 18,
      width: 5,
      height: 104
    }
  end

  @spec fretboard() :: fretboard_map()
  def fretboard do
    %{
      x: 80,
      y: 19,
      width: 504,
      height: 103,
      rx: 2
    }
  end
end
