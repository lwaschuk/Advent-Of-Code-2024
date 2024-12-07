//
//  Day_7.swift
//  AoC-2024
//
//  Created by Lukas Waschuk on 11/25/24.
//
import Algorithms
import Foundation

class Day_07 {
  //  let input: [String] = File_Utils().readFile(named: "d7_e1", withExtension: "txt")
  //  let input: [String] = File_Utils().readFile(named: "d7_e2", withExtension: "txt")
  let input: [String] = File_Utils().readFile(named: "d7", withExtension: "txt")
  let helper = Helper()
  
  func run() {
    part1()
    part2()
  }
  
  func part1(part2: Bool = false) {
    let data = helper.deserialize(input)
    
    var totalCalibrationResult: [Int] = []
    
    for line in data {
      let calibrationResult = line.0
      let values = line.1
      let numOperators = values.count - 1

      var allCombinations: [[Operation]] = []
      if part2 {
        allCombinations = Array(repeating: Operation.allCases, count: numOperators)
      } else {
        allCombinations = Array(repeating: Operation.allCases.filter({ $0 != .CONCAT }), count: numOperators)
      }
      
      let combinations = cartesianProduct(of: allCombinations)
      var found = false
      
      for opCombination in combinations {
        var sum = values[0]
        
        for i in 0..<opCombination.count {
          sum = Int(opCombination[i].perform(Int64(values[i + 1]), Int64(sum)))
        }
        
        if sum == calibrationResult {
          found = true
          break
        }
      }
      
      if found {
        totalCalibrationResult.append(calibrationResult)
      }
    }
    
    print("Part \(part2 ? "2" : "1"): \(totalCalibrationResult.reduce(0, +))")
  }
  
  func part2() {
    part1(part2: true)
  }
  
  func cartesianProduct<T>(of arrays: [[T]]) -> [[T]] {
    guard let first = arrays.first else { return [[]] }
    let rest = cartesianProduct(of: Array(arrays.dropFirst()))
    return first.flatMap { value in rest.map { [value] + $0 } }
  }
  
  enum Operation: String, CaseIterable {
    case ADD
    case MUL
    case CONCAT
    // FFFFFFFFFFFFFFFFFF
    // case SUB
    // case DIV
    
    func perform(_ value: Int64, _ total: Int64) -> Int64 {
      switch self {
        case .ADD: return total + value
        case .MUL: return total * value
        case .CONCAT:
          let concatenated = "\(total)\(value)"
          return Int64(concatenated)!
        // FFFFFFFFFFFFFFFFFFFFFFF
        // case .SUB: return total - value
        // case .DIV: return total / value
      }
    }
  }

  internal class Helper {
    func deserialize(_ input: [String]) -> [(Int, [Int])]{
      var array: [(Int, [Int])] = []
      for line in input {
        guard !line.isEmpty else { continue }
        let split = line.split(separator: ":")
        var values: [Int] = []
        let total = Int(split[0])!
        split[1].split(separator: " ").forEach {
          values.append(Int($0)!)
        }
        array.append((total, values))
      }
      return array
    }
  }
}
