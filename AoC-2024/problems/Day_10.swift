//
//  Day_10.swift
//  AoC-2024
//
//  Created by Lukas Waschuk on 11/25/24.
//
import os
import Foundation

class Day_10 {
  //  let input: [String] = File_Utils().readFile(named: "d10_e1", withExtension: "txt")
  //  let input: [String] = File_Utils().readFile(named: "d10_e2", withExtension: "txt")
  let input: [String] = File_Utils().readFile(named: "d10", withExtension: "txt")
  let helper = Helper()
  var rows: Int = 0
  var columns: Int = 0
  
  func run() {
    part1()
    part2()
  }
  
  func part1(runP2: Bool = false) {
    var map = helper.deserialize(input)
    rows = map.count
    columns = map[0].count
    
    var ret: [Int] = []
    
    var start = setPosition(toFirstOccuranceOf: 0, in: map)
    
    while let position = start {
      var baseMap = map
      
      var recursiveCount: Int = 0
      dfs(map: &baseMap, position: position, recursiveCount: &recursiveCount, part2: runP2)
      
      ret.append(recursiveCount)
      map[position.row][position.column] = -1
      start = setPosition(toFirstOccuranceOf: 0, in: map)
    }
    
    print("Part \(runP2 ? "2" : "1"): \(ret.reduce(0, +))")
  }
  
  func part2() {
    part1(runP2: true)
  }
  
  func dfs(map: inout [[Int]], position: Position, recursiveCount: inout Int, part2: Bool = false) {
    let currentIncline = map[position.row][position.column]
    guard currentIncline != 9 else {
      recursiveCount += 1
      
      // part 2 is just not invalidating the 9 lmao
      if !part2 {
        map[position.row][position.column] = -1
      }
      return
    }
    
    for dir in Direction.CARDINAL {
      let pos = position + dir
      if inBounds(position: pos) {
        if map[pos.row][pos.column] == currentIncline + 1 {
          dfs(map: &map, position: pos, recursiveCount: &recursiveCount, part2: part2)
        }
      }
    }
  }
  
  func inBounds(position: Position) -> Bool {
    position.row >= 0 && position.row < rows && position.column >= 0 && position.column < columns
  }
  
  func setPosition(toFirstOccuranceOf number: Int, in input: [[Int]]) -> Position? {
    for (index_Y, row) in input.enumerated() {
      for (index_X, _) in row.enumerated() {
        if input[index_Y][index_X] == number {
          return Position(row: index_Y, column: index_X)
        }
      }
    }
    return nil
  }
  
  internal class Helper {
    func deserialize(_ input: [String]) -> [[Int]] {
      var array: [[Int]] = []
      for line in input {
        guard !line.isEmpty else { continue }
        var temp: [Int] = []
        for number in line {
          temp.append(Int(String(number))!)
        }
        array.append(temp)
      }
      return array
    }
  }
}
