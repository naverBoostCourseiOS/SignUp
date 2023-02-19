//
//  UIStackView+Extension.swift
//  SignUp
//
//  Created by hyosung on 2023/02/19.
//

import UIKit

extension UIStackView {
  func addArrangeSubViews(_ views: UIView...) {
    views.forEach { self.addArrangedSubview($0) }
  }
}
