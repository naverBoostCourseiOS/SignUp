//
//  PasswordRegexCalculator.swift
//  SignUp
//
//  Created by hyosung on 2023/02/22.
//

protocol PasswordRegexCalculatable {
  func calculate(_ string: String) throws -> Bool
}

struct PasswordRegexCalculator: PasswordRegexCalculatable {
  
  static let regex: String = ".{5,}"
  
  private let regexCalculateService: RegexCalculateServicable
  
  init(_ regexCalculateService: RegexCalculateServicable) {
    self.regexCalculateService = regexCalculateService
  }
}

extension PasswordRegexCalculator {
  func calculate(_ string: String) throws -> Bool {
    try regexCalculateService.calculate(string)
  }
}
