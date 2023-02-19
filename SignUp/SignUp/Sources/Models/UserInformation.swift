//
//  UserInformation.swift
//  SignUp
//
//  Created by Doyeon on 2023/02/19.
//

import Foundation

class UserInformation {
    
    // MARK: - Properties
    static let shared = UserInformation()
    var id: String?
    var pw: String?
    var introduction: String?
    var phone: String?
    var birthday: Date?
    
    // MARK: - Methods
    private init() {}
    
    func saveBasicInfo(id: String?, pw: String?, introduction: String?) {
        self.id = id
        self.pw = pw
        self.introduction = introduction
    }
    
    func saveAdditionalInfo(phone: String?, birthday: Date?) {
        self.phone = phone
        self.birthday = birthday
    }
}
