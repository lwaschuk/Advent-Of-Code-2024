//
//  ArrayNavigation.swift
//  AoC-2024
//
//  Created by Lukas Waschuk on 12/4/24.
//

import Foundation

/// A utility class for navigating and interacting with a 2D array of characters.
class ArrayNavigation {
  var input: [[Character]]
  let columns: Int
  let rows: Int
  var currentPosition: Position = Position(row: 0, column: 0)

  init(input: [[Character]]) {
    self.input = input
    self.columns = input[0].count
    rows = input.count
  }

  /// Update the array location to a provided char
  func updateCharacter(to character: Character) {
    input[currentPosition.row][currentPosition.column] = character
  }
  
  /// Update a position in the array location to a provided char
  func updateCharacter(at position: Position, to character: Character) {
    input[position.row][position.column] = character
  }
  
  /// Set the position to the first occurance of a character
  ///
  /// Example: In a map where someones starting position is a ^
  func setPosition(toFirstOccuranceOf character: Character) {
    for (index_Y, row) in input.enumerated() {
      for (index_X, _) in row.enumerated() {
        if input[index_Y][index_X] == character {
          currentPosition = Position(row: index_Y, column: index_X)
          return
        }
      }
    }
  }
  
  /// Get the current character at the current position pointer
  func currentCharacter() -> Character {
    return input[currentPosition.row][currentPosition.column]
  }

  /// Get the character at a given position
  func getCharacter(at position: Position) -> Character? {
    guard inBounds(position: position) else { return nil }
    return input[position.row][position.column]
  }

  /// Get the character at a given direction from the current position
  func getCharacter(at direction: Direction) -> Character? {
    guard inBounds(position: currentPosition + direction) else { return nil }
    return input[currentPosition.row + direction.row][currentPosition.column + direction.column]
  }

  /// Move the pointer in a given direction
  func move(to direction: Direction) throws {
    guard inBounds(position: currentPosition + direction) else { throw NavigationError.outOfBounds }
    currentPosition = currentPosition + direction
  }

  /// Get the next character in a given direction with a given offset
  func nextCharacters(next offset: Int, in direction: Direction) -> String? {
    guard getCharacter(at: direction * offset) != nil else { return nil }
    var nextCharacters: String = ""
    var pointer = currentPosition

    nextCharacters.append(getCharacter(at: pointer)!)
    for _ in 0..<offset {
      //      print(pointer)
      pointer = movePointer(from: pointer, in: direction)
      nextCharacters.append(getCharacter(at: pointer)!)
    }

    return nextCharacters
  }

  /// Move the pointer down by one and reset the column to 0
  func moveDownAndCR() throws {
    guard inBounds(position: Position(row: currentPosition.row, column: currentPosition.column + 1))
    else {
      throw NavigationError.columnOutOfBounds
    }
    currentPosition = Position(row: 0, column: currentPosition.column + 1)
  }

  /// Move the pointer left by one
  func moveRight() throws {
    guard inBounds(position: Position(row: currentPosition.row + 1, column: 0)) else {
      throw NavigationError.rowOutOfBounds
    }
    currentPosition = Position(row: currentPosition.row + 1, column: currentPosition.column)
  }

  /// Print the immediate surroundings of the current location
  func surrounding() {
    let nw = getCharacter(at: .NORTH_WEST) ?? " "
    let n = getCharacter(at: .NORTH) ?? " "
    let ne = getCharacter(at: .NORTH_EAST) ?? " "
    let e = getCharacter(at: .EAST) ?? " "
    let cur = currentCharacter()
    let w = getCharacter(at: .WEST) ?? " "
    let sw = getCharacter(at: .SOUTH_WEST) ?? " "
    let s = getCharacter(at: .SOUTH) ?? " "
    let se = getCharacter(at: .SOUTH_EAST) ?? " "
    print(
      """
       -----------
      | \(nw) - \(n) - \(ne) |
      | \(w) - \(cur) - \(e) |
      | \(sw) - \(s) - \(se) |
       -----------

      """)
  }

  /// Move the pointer in any direction by one
  ///
  /// To be used internally by `nextCharacter`
  private func movePointer(from: Position, in to: Direction) -> Position {
    Position(row: from.row + to.row, column: from.column + to.column)
  }

  /// Check if a position is within the bounds of the array
  private func inBounds(position: Position) -> Bool {
    position.row >= 0 && position.row < rows && position.column >= 0 && position.column < columns
  }
}
