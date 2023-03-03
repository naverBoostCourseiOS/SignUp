//
//  PhoneRegexCalculator.swift
//  SignUp
//
//  Created by hyosung on 2023/03/03.
//

protocol PhoneRegexCalculatable {
  func calculate(_ string: String) throws -> Bool
}

struct PhoneRegexCalculator: PhoneRegexCalculatable {
  
  static let regex: String = "^010-\\d{4}-\\d{4}$"
  
  private let regexCalculateService: RegexCalculateServicable
  
  init(_ regexCalculateService: RegexCalculateServicable) {
    self.regexCalculateService = regexCalculateService
  }
}

extension PhoneRegexCalculator {
  func calculate(_ string: String) throws -> Bool {
    try regexCalculateService.calculate(string)
  }
}
