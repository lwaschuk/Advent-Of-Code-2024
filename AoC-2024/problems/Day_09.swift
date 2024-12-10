//
//  Day_9.swift
//  AoC-2024
//
//  Created by Lukas Waschuk on 11/25/24.
//

import Foundation
import os
class Day_09 {
  // let input: [String] = File_Utils().readFile(named: "d9_e1", withExtension: "txt")
  //  let input: [String] = File_Utils().readFile(named: "d9_e2", withExtension: "txt")
  let input: [String] = File_Utils().readFile(named: "d9", withExtension: "txt")
  let helper = Helper()
  let logger = Logger()

  func run() {
    part1()
    part2()
  }

  func part1() {
    let data: [[Character]] = helper.deserialize(input)
    var checksum: Int = 0
    for line in data {
      var translatedData = translate(input: line)
      
      var rightPointer: Int = translatedData.count - 1
      var leftPointer: Int = 0
      
      while leftPointer < rightPointer {
        let leftChar = translatedData[leftPointer]
        let rightChar = translatedData[rightPointer]
        
        guard leftChar == "." else {
          leftPointer += 1
          continue
        }
        guard rightChar != "." else {
          rightPointer -= 1
          continue
        }
        
        translatedData[leftPointer] = rightChar
        leftPointer += 1
        rightPointer -= 1
      }
      
      for i in rightPointer + 1..<translatedData.count {
        translatedData[i] = "."
      }
      
      checksum += calculateChecksum(translatedData)
      
      logger.info("Part 1: \(checksum)")
    }
  }

  func part2() {
    let data: [[Character]] = helper.deserialize(input)
    var checksum: Int = 0
    
    for line in data {
      var translatedData = translate(input: line)
      var fileSpans = getFileSpans(translatedData)
      var freeSpans = getFreeSpans(translatedData)
      
      fileSpans.sort { $0.id > $1.id }
      
      for file in fileSpans {
        moveFile(&translatedData, &freeSpans, file)
      }
      
      checksum += calculateChecksum(translatedData)
    }
    
    logger.info("Part 2: \(checksum)")
  }

  private func moveFile(
    _ data: inout [String],
    _ freeSpans: inout [(start: Int, length: Int)],
    _ file: (id: Int, start: Int, length: Int)
  ) {
    // move to the leftmost (first) free spot
    if let freeIndex = freeSpans.firstIndex(where: { $0.length >= file.length && $0.start < file.start }) {
      let freeSpan = freeSpans[freeIndex]
      
      for i in 0..<file.length {
        data[freeSpan.start + i] = String(file.id)
      }
      
      // make location of the file ","
      for i in file.start..<file.start + file.length {
        data[i] = "."
      }
      
      // update the free spans
      let newFreeSpan = (start: file.start, length: file.length)
      freeSpans[freeIndex] = (start: freeSpan.start + file.length, length: freeSpan.length - file.length)
      freeSpans.append(newFreeSpan)
      freeSpans.sort { $0.start < $1.start }
    }
  }

  private func getFreeSpans(_ data: [String]) -> [(start: Int, length: Int)] {
    var freeSpans: [(start: Int, length: Int)] = []
    
    for (index, char) in data.enumerated() {
      if char == "." {
        if freeSpans.isEmpty || freeSpans.last!.start + freeSpans.last!.length != index {
          freeSpans.append((start: index, length: 1))
        } else {
          freeSpans[freeSpans.count - 1].length += 1
        }
      }
    }
    
    return freeSpans
  }
  
  private func getFileSpans(_ data: [String]) -> [(id: Int, start: Int, length: Int)] {
    var fileSpans: [(id: Int, start: Int, length: Int)] = []
    var currentID: Int? = nil
    var startIndex = 0
    
    for (index, char) in data.enumerated() {
      if char == "." {
        if let current = currentID {
          fileSpans.append((id: current, start: startIndex, length: index - startIndex))
          currentID = nil
        }
      } else if let id = Int(char) {
        if currentID == nil {
          currentID = id
          startIndex = index
        } else if currentID != id {
          fileSpans.append((id: currentID!, start: startIndex, length: index - startIndex))
          currentID = id
          startIndex = index
        }
      }
    }
    
    if let id = currentID {
      fileSpans.append((id: id, start: startIndex, length: data.count - startIndex))
    }
    
    return fileSpans
  }

  private func translate(input: [Character]) -> [String] {
    var output: [String] = []
    var id: Int = 0
    
    for i in 0..<input.count {
      switch i % 2 {
        case 0:
          output.append(contentsOf: Array(repeating: String(id), count: Int(String(input[i]))!))
          id += 1
        case 1:
          output.append(contentsOf: Array(repeating: ".", count: Int(String(input[i]))!))
        default : continue
      }
    }
    return output
  }
  
  private func calculateChecksum(_ data: [String]) -> Int {
    var checksum = 0
    for (index, char) in data.enumerated() {
      guard char != "." else { continue }
      checksum += Int(char)! * index
    }
    return checksum
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
