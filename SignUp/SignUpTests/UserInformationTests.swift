//
//  UserInformationTests.swift
//  SignUpTests
//
//  Created by hyosung on 2023/02/20.
//

import XCTest
@testable import SignUp

final class UserInformationTests: XCTestCase {
  
  var userInformation: UserInformationable?
  
  override func setUpWithError() throws {
    userInformation = UserInformation.shared
  }
  
  override func tearDownWithError() throws {
    userInformation = nil
  }
}

extension UserInformationTests {
  func testUserSetAndGet() {
      let userInformation = UserInformation.shared
      let user = User(ID: "testID", password: "testPassword", profileImage: nil, introduction: nil, phone: nil, birth: nil)
      
      userInformation.setUser(
        ID: user.ID,
        password: user.password,
        profileImage: user.profileImage,
        introduction: user.introduction,
        phone: user.phone,
        birth: user.birth
      )
      
      XCTAssertEqual(userInformation.user(), user)
    }
    
    func testSetAndGetID() {
      let userInformation = UserInformation.shared
      let ID = "testID"
      
      userInformation.setID(ID)
      
      XCTAssertEqual(userInformation.ID(), ID)
    }
    
    func testSetAndGetPassword() {
      let userInformation = UserInformation.shared
      let password = "testPassword"
      
      userInformation.setPassword(password)
      
      XCTAssertEqual(userInformation.password(), password)
    }
    
    func testSetAndGetProfileImage() {
      let userInformation = UserInformation.shared
      let profileImage = UIImage(named: "testImage")
      
      userInformation.setProfileImage(profileImage)
      
      XCTAssertEqual(userInformation.profileImage(), profileImage)
    }
    
    func testSetAndGetIntroduction() {
      let userInformation = UserInformation.shared
      let introduction = "testIntroduction"
      
      userInformation.setIntroduction(introduction)
      
      XCTAssertEqual(userInformation.introduction(), introduction)
    }
    
    func testSetAndGetPhone() {
      let userInformation = UserInformation.shared
      let phone = "010-1234-5678"
      
      userInformation.setPhone(phone)
      
      XCTAssertEqual(userInformation.phone(), phone)
    }
    
    func testSetAndGetBirth() {
      let userInformation = UserInformation.shared
      let birth = Date()
      
      userInformation.setBirth(birth)
      
      XCTAssertEqual(userInformation.birth(), birth)
    }
    
    func testClearUser() {
      let userInformation = UserInformation.shared
      
      userInformation.setUser(
        ID: "testID",
        password: "testPassword",
        profileImage: nil,
        introduction: nil,
        phone: nil,
        birth: nil
      )
      
      userInformation.clear()
      
      XCTAssertNil(userInformation.user())
    }
}
