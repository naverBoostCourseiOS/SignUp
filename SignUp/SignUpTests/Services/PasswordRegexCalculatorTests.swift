//
//  PasswordRegexCalculatorTests.swift
//  SignUpTests
//
//  Created by hyosung on 2023/02/22.
//

import XCTest

@testable import SignUp

final class PasswordRegexCalculatorTests: XCTestCase {
  
  var regexCalculateService: RegexCalculateServiceMock?
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    
  }
  
  override func tearDownWithError() throws {
    try super.tearDownWithError()
    regexCalculateService = nil
  }
}

extension PasswordRegexCalculatorTests {
  func testTruePassword() {
    let regexCalculateService = RegexCalculateServiceMock(result: true)
    let calculator = PasswordRegexCalculator(regexCalculateService)
    
    XCTAssertTrue(try calculator.calculate("ABCDE"))
  }
  
  func testFalseIDPassword() {
    let regexCalculateService = RegexCalculateServiceMock(result: false)
    let calculator = PasswordRegexCalculator(regexCalculateService)
    
    XCTAssertFalse(try calculator.calculate("1234"))
  }
}
