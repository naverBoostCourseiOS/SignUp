//
//  UIView+Extension.swift
//  SignUp
//
//  Created by Doyeon on 2023/02/18.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}
