//
//  Int+greatestCommonDivisor.swift
//  AoC-2024
//
//  Created by Lukas Waschuk on 12/7/24.
//

import Foundation

extension Int {
  func greatestCommonDivisor(with b: Int) -> Int {
    var (a, b) = (self, b)
    while b != 0 {
      (a, b) = (b, a % b)
    }
    return abs(a)
  }
}
