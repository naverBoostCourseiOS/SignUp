//
//  UIViewController+Extension.swift
//  SignUp
//
//  Created by Doyeon on 2023/02/19.
//
import UIKit

extension UIViewController {
    func makeImageView(name: String) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: name)
        return imageView
    }
    
    func makeTextField(withPlaceholder placeholder: String, isSecureTextEntry: Bool) -> UITextField {
        let textField = UITextField()
        textField.font = UIFont.Pretendard(type: .Medium, size: 20)
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = isSecureTextEntry
        return textField
    }
    
    func makeButton(withTitle title: String, titleColor: UIColor) -> UIButton {
        let button = UIButton()
        button.titleLabel?.font = UIFont.Pretendard(type: .Medium, size: 20)
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        return button
    }
    
    func makeStackView(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.axis = axis
        stackView.distribution = .fillEqually
        stackView.spacing = spacing
        return stackView
    }
}
