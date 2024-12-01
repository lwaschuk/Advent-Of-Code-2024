//
//  Day_1.swift
//  AoC-2024
//
//  Created by Lukas Waschuk on 11/25/24.
//
import Foundation

class Day_01 {
  //    let input: [String] = File_Utils().readFile(named: "d1_e1", withExtension: "txt")
  //    let input: [String] = File_Utils().readFile(named: "d1_e2", withExtension: "txt")
  let input: [String] = File_Utils().readFile(named: "d1", withExtension: "txt")
  let helper = Helper()

  func run() {
    part1()
    part2()
  }

  func part1() {
    let data = helper.deserialize(input)
    let difference = zip(data.0, data.1).map({ abs($0.0 - $0.1) })
    print("Part 1: \(difference.reduce(0, +))")
  }

  func part2() {
    let data = helper.deserialize(input)
    let score = data.0.map({ first in data.1.filter({ $0 == first }).count * first })
    print("Part 2: \(score.reduce(0, +))")
  }

  internal class Helper {
    func deserialize(_ input: [String]) -> ([Int], [Int]) {
      var first: [Int] = []
      var second: [Int] = []

      for line in input {
        guard !line.isEmpty else { continue }
        let split = line.split(separator: " ")
        first.append(Int(split[0])!)
        second.append(Int(split[1])!)
      }
      return (first.sorted(by: <), second.sorted(by: <))
    }
  }
}
