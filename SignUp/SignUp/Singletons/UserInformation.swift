//
//  UserInformation.swift
//  SignUp
//
//  Created by hyosung on 2023/02/20.
//

import UIKit

protocol UserInformationable {
  func user() -> User?
  func setUser(ID: String?, password: String?, profileImage: UIImage?, introduction: String?, phone: String?, birth: Date?)
  func setID(_ ID: String)
  func ID() -> String?
  func setPassword(_ password: String)
  func password() -> String?
  func setProfileImage(_ profileImage: UIImage?)
  func profileImage() -> UIImage?
  func setIntroduction(_ introduction: String)
  func introduction() -> String?
  func setPhone(_ phone: String)
  func phone() -> String?
  func setBirth(_ birth: Date)
  func birth() -> Date?
  func clear()
}

final class UserInformation: UserInformationable {
  static let shared: UserInformationable = UserInformation()
  private var _user: User?
  
  private init() { }
}

// MARK: - Private Functions
extension UserInformation {
  private func createUser() {
    _user = User(
      ID: nil,
      password: nil,
      profileImage: nil,
      introduction: nil,
      phone: nil,
      birth: nil
    )
  }
}

// MARK: - Functions
extension UserInformation {
  func user() -> User? {
    return _user
  }
  
  func setUser(
    ID: String?,
    password: String?,
    profileImage: UIImage?,
    introduction: String?,
    phone: String?,
    birth: Date?
  ) {
    _user = User(
      ID: ID,
      password: password,
      profileImage: profileImage,
      introduction: introduction,
      phone: phone,
      birth: birth
    )
  }
  
  func setID(_ ID: String) {
    if _user == nil { createUser() }
    _user?.ID = ID
  }
  
  func ID() -> String? {
    _user?.ID
  }
  
  func setPassword(_ password: String) {
    if _user == nil { createUser() }
    _user?.password = password
  }
  
  func password() -> String? {
    _user?.password
  }
  
  func setProfileImage(_ profileImage: UIImage?) {
    if _user == nil { createUser() }
    _user?.profileImage = profileImage
  }
  
  func profileImage() -> UIImage? {
    _user?.profileImage
  }
  
  func setIntroduction(_ introduction: String) {
    if _user == nil { createUser() }
    _user?.introduction = introduction
  }
  
  func introduction() -> String? {
    _user?.introduction
  }
  
  func setPhone(_ phone: String) {
    if _user == nil { createUser() }
    _user?.phone = phone
  }
  
  func phone() -> String? {
    _user?.phone
  }
  
  func setBirth(_ birth: Date) {
    if _user == nil { createUser() }
    _user?.birth = birth
  }
  
  func birth() -> Date? {
    _user?.birth
  }
  
  func clear() {
    _user = nil
  }
}
