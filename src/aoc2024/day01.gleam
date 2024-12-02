import aocutil
import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string

fn string_to_tuple(line: String) {
  case string.split_once(line, on: " ") {
    Ok(#(val1, val2)) -> #(string.trim(val1), string.trim(val2))
    Error(_) -> #("0", "0")
  }
}

fn make_list_tuple(input: String) -> #(List(String), List(String)) {
  input
  |> string.split("\n")
  |> list.map(string_to_tuple)
  |> list.unzip()
}

fn make_int_list_tuple(input: String) -> #(List(Int), List(Int)) {
  let #(list1, list2) = make_list_tuple(input)
  #(to_sorted_int_list(list1), to_sorted_int_list(list2))
}

fn to_sorted_int_list(list: List(String)) -> List(Int) {
  list
  |> list.map(int.parse)
  |> list.map(fn(x) { x |> result.unwrap(0) })
  |> list.sort(int.compare)
}

pub fn part1(input: String) {
  let #(numlist1, numlist2) = make_int_list_tuple(input)

  list.zip(numlist1, numlist2)
  |> list.map(fn(pair) { int.absolute_value(pair.0 - pair.1) })
  |> int.sum()
}

pub fn part2(input: String) {
  let #(numlist1, numlist2) = make_int_list_tuple(input)

  numlist1
  |> list.map(fn(x) { x * list.count(numlist2, fn(y) { x == y }) })
  |> int.sum()
}

pub fn runner() {
  let input = aocutil.read_aoc_data(2024, 1, 1)
  let result1 = part1(input)
  let result2 = part2(input)
  io.println("Day 01, part 1: " <> int.to_string(result1))
  io.println("Day 01, part 2: " <> int.to_string(result2))
}
