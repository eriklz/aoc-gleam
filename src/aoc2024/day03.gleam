import aocutil
import gleam/regexp.{Match}
import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/option.{Some}

pub fn part1(input) {
  find_multiplications(input)
  |> list.map(extract_numbers)
  |> list.map(multiply_pair)
  |> int.sum
}

pub fn part2(input) {
  let filtered_list = find_multiplications_and_toggles(input)
  |> filter_multiplications
  
  filtered_list
  |> list.map(extract_numbers)
  |> list.map(multiply_pair)
  |> int.sum
}

pub fn runner() {
  let input = aocutil.read_aoc_data(2024, 3, 1)
  let result1 = part1(input)
  let result2 = part2(input)
  io.println("Day 03, part 1: " <> int.to_string(result1))
  io.println("Day 03, part 2: " <> int.to_string(result2))
}

fn string_to_int(input) {
  int.parse(input) |> result.unwrap(0)
}

fn find_multiplications(input: String) {
  let options = regexp.Options(case_insensitive: False, multi_line: True)
  let assert Ok(re) = regexp.compile("mul\\((\\d{1,3}),(\\d{1,3})\\)", with: options)
  regexp.scan(with: re, content: input)
}

fn find_multiplications_and_toggles(input: String) {
  let options = regexp.Options(case_insensitive: False, multi_line: True)
  let assert Ok(re) = regexp.compile("(mul\\((\\d{1,3}),(\\d{1,3})\\)|do\\(\\)|don't\\(\\))", with: options)
  regexp.scan(with: re, content: input)
}

fn filter_multiplications(matches) {
  let #(_, filtered_list) = list.fold(matches, #(True, []), fn (acc, match) {
    let #(toogle, list) = acc
    case match {
      Match("do()", _) -> #(True, list) 
      Match("don't()", _) -> #(False, list)
      Match(m, [_, val1, val2]) if toogle -> #(toogle, [Match(m, [val1, val2]), ..list])
      _ -> acc
    }
  })
  filtered_list
}

type Pair = #(Int, Int)

fn multiply_pair(tuple: Pair) {
  tuple.0 * tuple.1
}

fn extract_numbers(match) {
  case match {
    Match(_, [Some(val1), Some(val2)]) ->  #(string_to_int(val1), string_to_int(val2))
    _ -> #(0, 0)
  }
}

