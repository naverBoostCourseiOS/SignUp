//
//  RegexCalculateServiceMock.swift
//  SignUpTests
//
//  Created by hyosung on 2023/02/22.
//

@testable import SignUp

final class RegexCalculateServiceMock: RegexCalculateServicable {
  
  private let pattern: String
  private var result: Bool = false
  
  init(pattern: String) {
    self.pattern = pattern
  }
  
  convenience init(result: Bool) {
    self.init(pattern: "")
    self.result = result
  }
  
  func calculate(_ string: String) throws -> Bool {
    return result
  }
}
