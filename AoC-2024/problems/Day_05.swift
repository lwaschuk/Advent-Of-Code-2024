//
//  Day_5.swift
//  AoC-2024
//
//  Created by Lukas Waschuk on 11/25/24.
//

class Day_05 {
  //  let input: [String] = File_Utils().readFile(named: "d5_e1", withExtension: "txt")
  //  let input: [String] = File_Utils().readFile(named: "d5_e2", withExtension: "txt")
  let input: [String] = File_Utils().readFile(named: "d5", withExtension: "txt")
  let helper = Helper()
  
  func run() {
    part1()
    part2()
  }
  
  func part1() {
    let (ordering, updates) = helper.deserialize(input)
    var middleValues: [Int] = []
    
    for update in updates {
      if isCorrectlyOrdered(update: update, ordering: ordering) {
        let middlePage = update[update.count / 2]
        middleValues.append(middlePage)
      }
    }
    
    print("Part 1: \(middleValues.reduce(0, +))")
  }
  
  func part2() {
    let (ordering, pageNumbers) = helper.deserialize(input)
    var middleValues: [Int] = []
    
    for update in pageNumbers {
      if !isCorrectlyOrdered(update: update, ordering: ordering) {
        let sortedUpdate = reorder(update, ordering: ordering)
        let middlePage = sortedUpdate[sortedUpdate.count / 2]
        middleValues.append(middlePage)
      }
    }
    
    print("Part 2: \(middleValues.reduce(0, +))")
  }
  
  func isCorrectlyOrdered(update: [Int], ordering: [(Int, Int)]) -> Bool {
    let pageIndex = Dictionary(uniqueKeysWithValues: update.enumerated().map { ($1, $0) })
    
    for (x, y) in ordering {
      if let index_X = pageIndex[x], let index_Y = pageIndex[y] {
        if index_X > index_Y {
          return false
        }
      }
    }
    
    return true
  }
  
  func reorder(_ update: [Int], ordering: [(Int, Int)]) -> [Int] {
    var sortedUpdate = update
    var swappedValues = true
    
    while swappedValues {
      swappedValues = false
      for (x, y) in ordering {
        if let index_X = sortedUpdate.firstIndex(of: x), let index_Y = sortedUpdate.firstIndex(of: y) {
          if index_X > index_Y {
            sortedUpdate.swapAt(index_X, index_Y)
            swappedValues = true
          }
        }
      }
    }
    
    return sortedUpdate
  }
  
  internal class Helper {
    func deserialize(_ input: [String]) -> ([(Int, Int)], [[Int]]) {
      var ordering: [(Int, Int)] = []
      var pageNumbers: [[Int]] = []
      
      for line in input {
        guard !line.isEmpty else { continue }
        
        if line.contains(",") {
          let split = line.split(separator: ",")
          var temp: [Int] = []
          
          for number in split {
            temp.append(Int(number)!)
          }
          
          pageNumbers.append(temp)
        }
        else if line.contains("|") {
          let split = line.split(separator: "|")
          ordering.append((Int(split[0])!, Int(split[1])!))
        }
      }
      return (ordering, pageNumbers)
    }
  }
}
