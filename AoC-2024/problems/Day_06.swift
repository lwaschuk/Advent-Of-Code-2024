//
//  Day_6.swift
//  AoC-2024
//
//  Created by Lukas Waschuk on 11/25/24.
//

class Day_06 {
  //    let input: [String] = File_Utils().readFile(named: "d6_e1", withExtension: "txt")
  //    let input: [String] = File_Utils().readFile(named: "d6_e2", withExtension: "txt")
  let input: [String] = File_Utils().readFile(named: "d6", withExtension: "txt")
  let helper = Helper()
  
  func run() {
    part1()
    part2()
  }
  
  func part1() {
    let map = helper.deserialize(input)
    var visited: [[Bool]] = Array(repeating: Array(repeating: false, count: map[0].count), count: map.count)
    let nav = ArrayNavigation(input: map)
    
    var run: Bool = true
    let directions: [Direction] = [.NORTH, .EAST, .SOUTH, .WEST]
    
    var currentDirection = 0
    
    nav.setPosition(toFirstOccuranceOf: "^")
    
    while run {
      visited[nav.currentPosition.row][nav.currentPosition.column] = true
      nav.updateCharacter(to: "X")
      
      if nav.getCharacter(at: directions[currentDirection]) == "#" {
        currentDirection = (currentDirection + 1) % 4
        continue
      }
      
      do {
        try nav.move(to: directions[currentDirection])
      } catch {
        run = false
      }
    }
    
    print("Part 1: \(visited.flatMap{ $0 }.filter{ $0 }.count)")
  }
  
  func part2() {
    let map = helper.deserialize(input)
    let directions: [Direction] = [.NORTH, .EAST, .SOUTH, .WEST]
    var nav = ArrayNavigation(input: map)
    var obstructionCount = 0
    
    for row in 0..<nav.rows {
      for col in 0..<nav.columns {
        let changedCell = Position(row: row, column: col)
        nav = ArrayNavigation(input: map)
        nav.setPosition(toFirstOccuranceOf: "^")
      
        if nav.getCharacter(at: changedCell) == "#" || (row == nav.currentPosition.row && col == nav.currentPosition.column) {
          continue
        }
        nav.updateCharacter(at: changedCell, to: "#")
        
        var visitedStates = Set<State>()
        var currentDirection = 0
        var run = true
        
        while run {
          let state = State(row: nav.currentPosition.row, column: nav.currentPosition.column, direction: currentDirection)
          
          if visitedStates.contains(state) {
            obstructionCount += 1
            break
          }
          visitedStates.insert(state)
          
          if nav.getCharacter(at: directions[currentDirection]) == "#" {
            currentDirection = (currentDirection + 1) % 4
            continue
          }
          
          do {
            try nav.move(to: directions[currentDirection])
          } catch {
            run = false
          }
        }
      }
    }
    
    print("Part 2: \(obstructionCount)")
  }
  
  struct State: Hashable {
    let row: Int
    let column: Int
    let direction: Int
  }
  
  internal class Helper {
    func deserialize(_ input: [String]) -> [[Character]] {
      var array: [[Character]] = []
      for line in input {
        guard !line.isEmpty else { continue }
        array.append(Array(line))
      }
      return array
    }
  }
}
