//
//  Math_Utils.swift
//  AoC-2024
//
//  Created by Lukas Waschuk on 12/7/24.
//

import Foundation

func gcd(_ a: Int, _ b: Int) -> Int {
  var (a, b) = (a, b)
  while b != 0 {
    (a, b) = (b, a % b)
  }
  return abs(a)
}

func gcd(_ vector: [Int]) -> Int {
  return vector.reduce(0, gcd)
}

func lcm(a: Int, b: Int) -> Int {
  return (a / gcd(a, b)) * b
}

func lcm(_ vector: [Int]) -> Int {
  return vector.reduce(1, lcm)
}
