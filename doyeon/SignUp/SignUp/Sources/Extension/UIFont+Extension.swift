//
//  UIFont+Extension.swift
//  SignUp
//
//  Created by Doyeon on 2023/02/17.
//

import UIKit

extension UIFont {
    static func Pretendard(type: PretendardType, size: CGFloat) -> UIFont {
        guard let font = UIFont(name: type.name, size: size) else {
            let defalutFont = systemFont(ofSize: size)
            return defalutFont
        }
        return font
    }
    
    public enum PretendardType {
        case Black
        case Bold
        case ExtraBold
        case ExtraLight
        case Light
        case Medium
        case Regular
        case SemiBold
        case Thin
        
        var name: String {
            switch self {
            case .Black:
                return "Pretendard-Black"
            case .Bold:
                return "Pretendard-Bold"
            case .ExtraBold:
                return "Pretendard-ExtraBold"
            case .ExtraLight:
                return "Pretendard-ExtraLight"
            case .Light:
                return "Pretendard-Light"
            case .Medium:
                return "Pretendard-Medium"
            case .Regular:
                return "Pretendard-Regular"
            case .SemiBold:
                return "Pretendard-SemiBold"
            case .Thin:
                return "Pretendard-Thin"
            }
        }
    }
}
