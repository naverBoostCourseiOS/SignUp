//
//  RegexCalculateServiceTests.swift
//  SignUpTests
//
//  Created by hyosung on 2023/02/22.
//

import XCTest

@testable import SignUp

final class RegexCalculateServiceTests: XCTestCase {

    override func setUpWithError() throws {
      try super.setUpWithError()
    }

    override func tearDownWithError() throws {
      try super.tearDownWithError()
    }
}

extension RegexCalculateServiceTests {
  func testTruePattern() {
    let service = RegexCalculateService(pattern: "[a-zA-Z]+")
    
    XCTAssertTrue(try service.calculate("Hello"))
    XCTAssertTrue(try service.calculate("World"))
  }
  
  func testFalsePattern() {
    let service = RegexCalculateService(pattern: "[0-9]+")
    
    XCTAssertFalse(try service.calculate("Hello"))
    XCTAssertFalse(try service.calculate("World"))
  }
  
  func testInvaildPattern() {
    let service = RegexCalculateService(pattern: "")
    
    XCTAssertThrowsError(try service.calculate("Hello"))
    XCTAssertThrowsError(try service.calculate("World"))
  }
}
