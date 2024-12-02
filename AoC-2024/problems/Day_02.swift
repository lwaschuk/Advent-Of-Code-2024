//
//  Day_2.swift
//  AoC-2024
//
//  Created by Lukas Waschuk on 11/25/24.
//
import Foundation

class Day_02 {
  //  let input: [String] = File_Utils().readFile(named: "d2_e1", withExtension: "txt")
  //  let input: [String] = File_Utils().readFile(named: "d2_e2", withExtension: "txt")
  let input: [String] = File_Utils().readFile(named: "d2", withExtension: "txt")
  let helper = Helper()

  func run() {
    part1()
    part2()
  }

  func part1() {
    var safeCount = 0

    for line in helper.deserialize(input) {
      if strictlyDecreasing(line) || strictlyIncreasing(line) { safeCount += 1 }
    }

    print("Part 1: \(safeCount)")
  }

  func part2() {
    var safeCount = 0

    for line in helper.deserialize(input) {
      var foundSafeVariation: Bool = false

      for line in getVariations(line) {
        if strictlyDecreasing(line) || strictlyIncreasing(line) { foundSafeVariation = true }
      }

      if foundSafeVariation { safeCount += 1 }
    }

    print("Part 2: \(safeCount)")
  }

  func getVariations(_ input: [Int]) -> [[Int]] {
    var variations: [[Int]] = []
    for i in 0..<input.count {
      var variation = input
      variation.remove(at: i)
      variations.append(variation)
    }
    return variations
  }

  func strictlyIncreasing(_ array: [Int]) -> Bool {
    let diffArray = zip(array.dropFirst(), array).map({ $0.0 - $0.1 })
    return diffArray.filter({ $0 >= -3 && $0 < 0 }).count == array.count - 1
  }

  func strictlyDecreasing(_ array: [Int]) -> Bool {
    let diffArray = zip(array.dropFirst(), array).map({ $0.0 - $0.1 })
    return diffArray.filter({ $0 <= 3 && $0 > 0 }).count == array.count - 1
  }

  internal class Helper {
    func deserialize(_ input: [String]) -> [[Int]] {
      var array: [[Int]] = []
      for line in input {
        guard !line.isEmpty else { continue }
        let split = line.split(separator: " ")
        array.append(split.map({ Int($0)! }))
      }
      return array
    }
  }
}
