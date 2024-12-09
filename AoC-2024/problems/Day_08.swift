//
//  Day_8.swift
//  AoC-2024
//
//  Created by Lukas Waschuk on 11/25/24.
//

class Day_08 {
  //  let input: [String] = File_Utils().readFile(named: "d8_e1", withExtension: "txt")
  //  let input: [String] = File_Utils().readFile(named: "d8_e2", withExtension: "txt")
  let input: [String] = File_Utils().readFile(named: "d8", withExtension: "txt")
  let helper = Helper()
  
  func run() {
    part1()
    part2()
  }
  
  func part1() {
    let data = helper.deserialize(input)
    let nav = ArrayNavigation(input: data)
    
    let antennaPositions = findAntennaPositions(nav: nav)
    
    var antinodePositions: Set<Position> = []
    
    for (_, positions) in antennaPositions {
      for i in 0..<positions.count {
        for j in i+1..<positions.count {
          let pos1 = positions[i]
          let pos2 = positions[j]
          
          let xDist = pos2.column - pos1.column
          let yDist = pos2.row - pos1.row
          
          let midpoint1 = Position(row: pos1.row - yDist, column: pos1.column - xDist)
          let midpoint2 = Position(row: pos2.row + yDist, column: pos2.column + xDist)
          
          if nav.inBounds(position: midpoint1) {
            antinodePositions.insert(midpoint1)
          }
          if nav.inBounds(position: midpoint2) {
            antinodePositions.insert(midpoint2)
          }
        }
      }
    }
    
    print("Part1: \(antinodePositions.count)")
  }
  
  func part2() {
    let data = helper.deserialize(input)
    let nav = ArrayNavigation(input: data)
    
    let antennaPositions = findAntennaPositions(nav: nav)
    
    var antinodePositions: Set<Position> = []
    
    for (_, positions) in antennaPositions {
      if positions.count > 1 {
        antinodePositions.formUnion(positions)
      }
      
      for i in 0..<positions.count {
        for j in i+1..<positions.count {
          let pos1 = positions[i]
          let pos2 = positions[j]
          
          let positionsOnLine = positionsBetween(pos1, pos2, in: nav)
          antinodePositions.formUnion(positionsOnLine)
        }
      }
    }
    
    print("Part 2: \(antinodePositions.count)")
  }
  
  private func findAntennaPositions(nav: ArrayNavigation) -> [Character: [Position]] {
    var antennaPositions: [Character: [Position]] = [:]
    for row in 0..<nav.rows {
      for col in 0..<nav.columns {
        let pos = Position(row: row, column: col)
        guard let char = nav.getCharacter(at: pos) else { continue }
        
        if char.isLetter || char.isNumber {
          antennaPositions[char, default: []].append(Position(row: row, column: col))
        }
      }
    }
    return antennaPositions
  }
  
  private func positionsBetween(_ pos1: Position, _ pos2: Position, in nav: ArrayNavigation) -> Set<Position> {
    var result: Set<Position> = []
    
    let xDist = pos2.column - pos1.column
    let yDist = pos2.row - pos1.row
    let gcd = abs(xDist.greatestCommonDivisor(with: yDist))
    
    let stepX = xDist / gcd
    let stepY = yDist / gcd
    
    var current = pos1
    while nav.inBounds(position: current) {
      result.insert(current)
      current = Position(row: current.row + stepY, column: current.column + stepX)
    }
    
    current = pos1
    while nav.inBounds(position: current) {
      result.insert(current)
      current = Position(row: current.row - stepY, column: current.column - stepX)
    }
    
    return result
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
