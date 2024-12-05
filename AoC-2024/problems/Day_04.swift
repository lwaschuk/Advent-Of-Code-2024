//
//  Day_4.swift
//  AoC-2024
//
//  Created by Lukas Waschuk on 11/25/24.
//

class Day_04 {
  //  let input: [String] = File_Utils().readFile(named: "d4_e1", withExtension: "txt")
  //  let input: [String] = File_Utils().readFile(named: "d4_e2", withExtension: "txt")
  let input: [String] = File_Utils().readFile(named: "d4", withExtension: "txt")
  let helper = Helper()

  func run() {
    part1()
    part2()
  }

  func part1() {
    let input = helper.deserialize(input)
    let nav = ArrayNavigation(input: input)

    var run = true
    var count = 0

    while run {
      if nav.currentCharacter() == "X" {
        if nav.nextCharacters(next: 3, in: .EAST) == "XMAS" { count += 1 }
        if nav.nextCharacters(next: 3, in: .WEST) == "XMAS" { count += 1 }
        if nav.nextCharacters(next: 3, in: .NORTH) == "XMAS" { count += 1 }
        if nav.nextCharacters(next: 3, in: .SOUTH) == "XMAS" { count += 1 }
        if nav.nextCharacters(next: 3, in: .NORTH_EAST) == "XMAS" { count += 1 }
        if nav.nextCharacters(next: 3, in: .NORTH_WEST) == "XMAS" { count += 1 }
        if nav.nextCharacters(next: 3, in: .SOUTH_EAST) == "XMAS" { count += 1 }
        if nav.nextCharacters(next: 3, in: .SOUTH_WEST) == "XMAS" { count += 1 }
      }

      do {
        try nav.moveRight()
      } catch {
        do {
          try nav.moveDownAndCR()
        } catch {
          run = false
        }
      }
    }
    print("Part 1: \(count)")
  }

  func part2() {
    let input = helper.deserialize(input)
    let nav = ArrayNavigation(input: input)

    var run = true
    var count = 0

    while run {
      if nav.currentCharacter() == "A" {
        let nw = nav.getCharacter(at: .NORTH_WEST)
        let ne = nav.getCharacter(at: .NORTH_EAST)
        let sw = nav.getCharacter(at: .SOUTH_WEST)
        let se = nav.getCharacter(at: .SOUTH_EAST)

        if ne == "M" && sw == "S" {
          if nw == "M" && se == "S" { count += 1 }
          else if nw == "S" && se == "M" { count += 1 }
        }

        if ne == "S" && sw == "M" {
          if nw == "M" && se == "S" { count += 1 }
          else if nw == "S" && se == "M" { count += 1 }
        }
      }

      do {
        try nav.moveRight()
      } catch {
        do {
          try nav.moveDownAndCR()
        } catch {
          run = false
        }
      }
    }

    print("Part 2: \(count)")
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
