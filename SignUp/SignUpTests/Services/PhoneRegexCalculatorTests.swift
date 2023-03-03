//
//  PhoneRegexCalculatorTests.swift
//  SignUpTests
//
//  Created by hyosung on 2023/03/03.
//

import XCTest

@testable import SignUp

final class PhoneRegexCalculatorTests: XCTestCase {
  var regexCalculateService: RegexCalculateServiceMock?
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    
  }
  
  override func tearDownWithError() throws {
    try super.tearDownWithError()
    regexCalculateService = nil
  }
}

extension PhoneRegexCalculatorTests {
  func testTruePhone() {
    let regexCalculateService = RegexCalculateServiceMock(result: true)
    let calculator = PhoneRegexCalculator(regexCalculateService)
    
    XCTAssertTrue(try calculator.calculate("01011112222"))
  }
  
  func testFalseIDPhone() {
    let regexCalculateService = RegexCalculateServiceMock(result: false)
    let calculator = PhoneRegexCalculator(regexCalculateService)
    
    XCTAssertFalse(try calculator.calculate("1234"))
  }
}
