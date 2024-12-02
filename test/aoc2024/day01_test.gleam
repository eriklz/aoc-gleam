import aoc2024/day01
import gleeunit/should

const input = "3   4
4   3
2   5
1   3
3   9
3   3"

pub fn day01_part1_test() {
  day01.part1(input)
  |> should.equal(11)
}

pub fn day01_part2_test() {
  day01.part2(input)
  |> should.equal(31)
}
