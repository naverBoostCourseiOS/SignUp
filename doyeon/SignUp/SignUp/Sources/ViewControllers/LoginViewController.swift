//
//  ViewController.swift
//  SignUp
//
//  Created by Doyeon on 2023/02/16.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    var textFieldStackView: UIStackView!
    var buttonStackView: UIStackView!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}

extension LoginViewController {
    
    // MARK: - Methods
    func setupViews() {
        let imageView = makeImageView(name: "myProfile")
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
        
        signUpBtn.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
    }
    
    // MARK: @objc
    @objc func signUpButtonTapped() {
        let signUpVC = SignUpViewController()
        signUpVC.modalPresentationStyle = .fullScreen
        signUpVC.modalTransitionStyle = .coverVertical
        present(signUpVC, animated: true)
    }
}
