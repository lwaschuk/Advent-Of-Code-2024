//
//  Direction.swift
//  AoC-2024
//
//  Created by Lukas Waschuk on 12/4/24.
//

import Foundation

struct Direction: Equatable, Comparable {
  let rawValue: (Int, Int)
  static let NORTH = Direction(rawValue: (-1, 0))
  static let SOUTH = Direction(rawValue: (1, 0))
  static let WEST = Direction(rawValue: (0, -1))
  static let EAST = Direction(rawValue: (0, 1))
  static let NORTH_EAST = NORTH + EAST
  static let NORTH_WEST = NORTH + WEST
  static let SOUTH_EAST = SOUTH + EAST
  static let SOUTH_WEST = SOUTH + WEST

  static func < (lhs: Direction, rhs: Direction) -> Bool {
    lhs.rawValue < rhs.rawValue
  }

  static func == (lhs: Direction, rhs: Direction) -> Bool {
    lhs.rawValue == rhs.rawValue
  }

  static func + (lhs: Direction, rhs: Direction) -> Direction {
    Direction(rawValue: (lhs.row + rhs.row, lhs.column + rhs.column))
  }

  static func - (lhs: Direction, rhs: Direction) -> Direction {
    Direction(rawValue: (lhs.row - rhs.row, lhs.column - rhs.column))
  }

  static func * (lhs: Direction, rhs: Int) -> Direction {
    Direction(rawValue: (lhs.row * rhs, lhs.column * rhs))
  }
}

extension Direction: CustomStringConvertible {
  var description: String {
    "(row:\(rawValue.0), column:\(rawValue.1))"
  }

  var row: Int {
    rawValue.0
  }

  var column: Int {
    rawValue.1
  }
}
