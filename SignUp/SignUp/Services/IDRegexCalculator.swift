//
//  IDRegexCalculator.swift
//  SignUp
//
//  Created by hyosung on 2023/02/22.
//

protocol IDRegexCalculatable {
  func calculate(_ string: String) throws -> Bool
}

struct IDRegexCalculator: IDRegexCalculatable {
  
  static let regex: String = ".{5,}"
  
  private let regexCalculateService: RegexCalculateServicable
  
  init(_ regexCalculateService: RegexCalculateServicable) {
    self.regexCalculateService = regexCalculateService
  }
}

extension IDRegexCalculator {
  func calculate(_ string: String) throws -> Bool {
    try regexCalculateService.calculate(string)
  }
}
