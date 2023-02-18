//
//  ViewController.swift
//  SignUp
//
//  Created by Doyeon on 2023/02/16.
//

import UIKit

class LoginViewController: UIViewController {
    
    var textFieldStackView: UIStackView!
    var buttonStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        let imageView = makeImageView()
        let idTextField = makeTextField(withPlaceholder: "ID", isSecureTextEntry: false)
        let pwTextField = makeTextField(withPlaceholder: "Password", isSecureTextEntry: true)
        let signInBtn = makeButton(withTitle: "Sign In", titleColor: .systemBlue)
        let signUpBtn = makeButton(withTitle: "Sign Up", titleColor: .systemRed)
        textFieldStackView = makeStackView(arrangedSubviews: [idTextField, pwTextField], axis: .vertical, spacing: 26)
        buttonStackView = makeStackView(arrangedSubviews: [signInBtn, signUpBtn], axis: .horizontal, spacing: 40)
        
        let views = [imageView, textFieldStackView, buttonStackView]
        views.forEach {
            $0!.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0!)
        }
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            
            idTextField.widthAnchor.constraint(equalToConstant: 250),
            idTextField.heightAnchor.constraint(equalToConstant: 40),
            
            pwTextField.widthAnchor.constraint(equalToConstant: 250),
            pwTextField.heightAnchor.constraint(equalToConstant: 40),
            
            textFieldStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textFieldStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 40),
            
            buttonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonStackView.topAnchor.constraint(equalTo: textFieldStackView.bottomAnchor, constant: 40)
        ])
    }
    
    private func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "myProfile")
        return imageView
    }
    
    private func makeTextField(withPlaceholder placeholder: String, isSecureTextEntry: Bool) -> UITextField {
        let textField = UITextField()
        textField.font = UIFont.Pretendard(type: .Medium, size: 20)
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = isSecureTextEntry
        return textField
    }
    
    private func makeButton(withTitle title: String, titleColor: UIColor) -> UIButton {
        let button = UIButton()
        button.titleLabel?.font = UIFont.Pretendard(type: .Medium, size: 20)
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        return button
    }
    
    private func makeStackView(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.axis = axis
        stackView.distribution = .fillEqually
        stackView.spacing = spacing
        return stackView
    }
}
