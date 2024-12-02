import aocutil
import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string

fn string_to_numlist(line: String) {
  string.split(line, on: " ")
  |> list.map(int.parse)
  |> result.values()
}

fn string_to_numlists(input: String) {
  input
  |> string.split("\n")
  |> list.map(string_to_numlist)
}

fn to_diff_list(numlist: List(Int)) -> List(Int) {
  list.window_by_2(numlist)
  |> list.map(fn(pair) { pair.0 - pair.1 })
}

fn is_safe(list: List(Int)) -> Bool {
  list.all(list, fn(x) { x > 0 && x < 4 })
  || list.all(list, fn(x) { x < 0 && x > -4 })
}

pub fn part1(input: String) {
  input
  |> string_to_numlists
  |> list.filter(fn(x) { !list.is_empty(x) })
  |> list.map(to_diff_list)
  |> list.filter(is_safe)
  |> list.length()
}

fn to_combination_list(list: List(Int)) -> List(List(Int)) {
  list
  |> list.combinations(by: list.length(list) - 1)
}

fn is_dampener_safe(list: List(List(Int))) -> Bool {
  let safe_list = list.map(list, is_safe)
  list.any(safe_list, fn(x) { x })
}

pub fn part2(input: String) {
  input
  |> string_to_numlists
  |> list.filter(fn(x) { !list.is_empty(x) })
  |> list.map(to_combination_list)
  |> list.map(fn(list) { list.map(list, to_diff_list) })
  |> list.filter(is_dampener_safe)
  |> list.length()
}

pub fn runner() {
  let input = aocutil.read_aoc_data(2024, 2, 1)
  let result1 = part1(input)
  let result2 = part2(input)
  io.println("Day 02, part 1: " <> int.to_string(result1))
  io.println("Day 02, part 2: " <> int.to_string(result2))
}
