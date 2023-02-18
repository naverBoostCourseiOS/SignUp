//
//  LoginViewController.swift
//  SignUp
//
//  Created by 강동영 on 2023/02/18.
//

import UIKit

class LoginViewController: UIViewController {

    var idTextfield: UITextField = {
        let textfield = UITextField(frame: .zero)
        textfield.placeholder = "ID"
        textfield.borderStyle = .roundedRect
        
        return textfield
    }()
    
    var passwordTextfield: UITextField = {
        let textfield = UITextField(frame: .zero)
        textfield.placeholder = "Password"
        textfield.borderStyle = .roundedRect
        
        return textfield
    }()
    
    var signInButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.tintColor, for: .normal)
        
        return button
    }()
    
    var signUpButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.red, for: .normal)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initLayout()
        signUpButton.addTarget(self, action: #selector(touchSignUpButton), for: .touchUpInside)
    }

    private func initLayout() {
        
        let logoImageView: UIImageView = UIImageView(frame: .zero)
        logoImageView.image = UIImage(named: "Logo")
        logoImageView.contentMode = .scaleAspectFit
        
        let containerStackView: UIStackView = UIStackView(frame: .zero)
        containerStackView.axis = .vertical
        containerStackView.spacing = 10
        containerStackView.distribution = .fill
        containerStackView.alignment = .fill
        
        let buttonStackView: UIStackView = UIStackView(frame: .zero)
        buttonStackView.axis = .horizontal
        buttonStackView.spacing = 0
        buttonStackView.distribution = .fillEqually
        buttonStackView.alignment = .center
        
        containerStackView.addArrangedSubview(idTextfield)
        containerStackView.addArrangedSubview(passwordTextfield)
        containerStackView.addArrangedSubview(buttonStackView)
        
        buttonStackView.addArrangedSubview(signInButton)
        buttonStackView.addArrangedSubview(signUpButton)
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(logoImageView)
        view.addSubview(containerStackView)
        
        NSLayoutConstraint.activate([
            
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            logoImageView.widthAnchor.constraint(equalToConstant: 150),
            logoImageView.widthAnchor.constraint(equalTo: logoImageView.heightAnchor, multiplier: 1.0),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            containerStackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 50),
            containerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            containerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
        ])
    }
    
    @objc
    func touchSignUpButton() {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: SignUpViewController.identifier) as? SignUpViewController else { return }
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

