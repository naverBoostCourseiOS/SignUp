//
//  RegexCalculateService.swift
//  SignUp
//
//  Created by hyosung on 2023/02/22.
//

import Foundation

protocol RegexCalculateServicable {
  init(pattern: String)
  func calculate(_ string: String) throws -> Bool
}

struct RegexCalculateService: RegexCalculateServicable {
  enum RegexError: Error {
    case catchError(Error)
  }
  
  private let pattern: String
  
  init(pattern: String) {
    self.pattern = pattern
  }
  
  func calculate(_ string: String) throws -> Bool {
    do {
      let regex = try NSRegularExpression(
        pattern: pattern,
        options: []
      )
      let result = regex
        .matches(
          in: string,
          options: [],
          range: NSRange(
            location: 0,
            length: string.count
          )
        )
        .compactMap {
          Range(
            $0.range,
            in: string
          )
        }
        .compactMap { String(string[$0]) }
      
      return result.isEmpty ? false : true
    } catch {
      throw RegexError.catchError(error)
    }
  }
}
