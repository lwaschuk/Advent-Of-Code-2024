//
//  Position.swift
//  AoC-2024
//
//  Created by Lukas Waschuk on 12/4/24.
//

import Foundation

struct Position {
  let row: Int
  let column: Int

  static func + (lhs: Position, rhs: Direction) -> Position {
    Position(row: lhs.row + rhs.row, column: lhs.column + rhs.column)
  }

  static func + (lhs: Position, rhs: Position) -> Position {
    Position(row: lhs.row + rhs.row, column: lhs.column + rhs.column)
  }

  static func == (lhs: Position, rhs: Position) -> Bool {
    lhs.row == rhs.row && lhs.column == rhs.column
  }

  static func == (lhs: Position, rhs: Direction) -> Bool {
    lhs.row == rhs.row && lhs.column == rhs.column
  }
}
