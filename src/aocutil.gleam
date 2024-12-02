import simplifile
import gleam/string
import gleam/int

pub fn make_aoc_filename(year: Int, day: Int, part: Int) -> String {
  let yeardir = int.to_string(year) <> "/"
  let daypartfile = 
    int.to_string(day)
    |> string.pad_start(2, "0")
    |> string.append("_part")
    |> string.append(int.to_string(part))
  "data/" <> yeardir <> "day" <> daypartfile <> ".txt"			
}

pub fn read_aoc_data(year: Int, day: Int, part: Int) -> String {
  let path = make_aoc_filename(year, day, part)
  let assert Ok(data) = simplifile.read(path)
  data
}
