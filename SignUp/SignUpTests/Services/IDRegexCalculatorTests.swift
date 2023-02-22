//
//  IDRegexCalculatorTests.swift
//  SignUpTests
//
//  Created by hyosung on 2023/02/22.
//

import XCTest

@testable import SignUp

final class IDRegexCalculatorTests: XCTestCase {
  
  var regexCalculateService: RegexCalculateServiceMock?
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    
  }
  
  override func tearDownWithError() throws {
    try super.tearDownWithError()
    regexCalculateService = nil
  }
}

extension IDRegexCalculatorTests {
  func testTrueID() {
    let regexCalculateService = RegexCalculateServiceMock(result: true)
    let calculator = IDRegexCalculator(regexCalculateService)
    
    XCTAssertTrue(try calculator.calculate("ABCDE"))
  }
  
  func testFalseID() {
    let regexCalculateService = RegexCalculateServiceMock(result: false)
    let calculator = IDRegexCalculator(regexCalculateService)
    
    XCTAssertFalse(try calculator.calculate("1234"))
  }
}
