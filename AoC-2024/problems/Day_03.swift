//
//  Day_3.swift
//  AoC-2024
//
//  Created by Lukas Waschuk on 11/25/24.
//

import Foundation

class Day_03 {
  //    let input: [String] = File_Utils().readFile(named: "d3_e1", withExtension: "txt")
  //    let input: [String] = File_Utils().readFile(named: "d3_e2", withExtension: "txt")
  let input: [String] = File_Utils().readFile(named: "d3", withExtension: "txt")
  let helper = Helper()

  func run() {
    part1()
    part2()
  }

  func part1() {
    let data = helper.deserialize(input)
    var count: [Int] = []

    let pattern = #"mul\(\d+,\d+\)"#

    for line in data {
      let regex = try! NSRegularExpression(pattern: pattern)
      let matches = regex.matches(
        in: line, options: [], range: NSRange(location: 0, length: line.utf16.count))

      for match in matches {
        guard let matchRange = Range(match.range, in: line) else { continue }

        let numbers =
          line[matchRange]
          .dropFirst(4)
          .dropLast(1)
          .split(separator: ",")
          .map({ Int($0)! })

        count.append(numbers[0] * numbers[1])
      }
    }

    print("Part 1: \(count.reduce(0, +))")
  }

  func part2() {
    let data = helper.deserialize(input)
    var total: [Int] = []

    var isEnabled = true
    let pattern = #"(do\(\)|don't\(\)|mul\(\d+,\d+\))"#

    for line in data {
      let regex = try! NSRegularExpression(pattern: pattern)
      let matches = regex.matches(
        in: line, options: [], range: NSRange(location: 0, length: line.utf16.count))

      for match in matches {
        guard let matchRange = Range(match.range, in: line) else { continue }
        let matchText = String(line[matchRange])

        switch matchText {
          case "do()":
            isEnabled = true
          case "don't()":
            isEnabled = false
          default:
            guard matchText.starts(with: "mul") && isEnabled else { continue }
            let numbers =
              matchText
              .dropFirst(4)
              .dropLast(1)
              .split(separator: ",")
              .map { Int($0)! }

            total.append(numbers[0] * numbers[1])
        }
      }
    }

    print("Total Sum: \(total.reduce(0, +))")
  }

  internal class Helper {
    func deserialize(_ input: [String]) -> [String] {
      var array: [String] = []
      for line in input {
        guard !line.isEmpty else { continue }
        array.append(line)
      }
      return array
    }
  }
}
