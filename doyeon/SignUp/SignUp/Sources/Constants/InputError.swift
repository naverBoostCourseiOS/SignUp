//
//  InputError.swift
//  SignUp
//
//  Created by Doyeon on 2023/02/20.
//

enum InputError: Error {
    case idEmpty
    case pwEmpty
    case pwCheck
    case pwMismatch
    
    var message: String {
        switch self {
        case .idEmpty:
            return "아이디를 입력해주세요."
        case .pwEmpty:
            return "비밀번호를 입력해주세요."
        case .pwCheck:
            return "비밀번호를 한번 더 입력해주세요."
        case .pwMismatch:
            return "비밀번호가 일치하지 않습니다."
        }
    }
}
