//
//  SignInViewController.swift
//  SignUp
//
//  Created by hyosung on 2023/02/19.
//

import UIKit

protocol SignInViewControllerDelegate: NSObject {
  func signIn()
  func signUp()
}

final class SignInViewController: UIViewController {
  
  // MARK: - Properties
  weak var delegate: SignInViewControllerDelegate?
  
  // MARK: -  UI Properties
  private let textFieldStackView: UIStackView = {
    let stackView: UIStackView = UIStackView()
    stackView.axis = .vertical
    stackView.distribution = .equalSpacing
    stackView.spacing = 12
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  private let IDTextField: UITextField = {
    let textField: UITextField = UITextField()
    textField.placeholder = "ID"
    textField.textColor = .black
    textField.layer.cornerRadius = 5
    textField.layer.masksToBounds = true
    textField.layer.borderWidth = 1
    textField.layer.borderColor = UIColor.lightGray.cgColor
    return textField
  }()
  private let passwordTextField :UITextField = {
    let textField: UITextField = UITextField()
    textField.placeholder = "Password"
    textField.textColor = .black
    textField.layer.cornerRadius = 5
    textField.layer.masksToBounds = true
    textField.layer.borderWidth = 1
    textField.layer.borderColor = UIColor.lightGray.cgColor
    return textField
  }()
  private let buttonStackView: UIStackView = {
    let stackView: UIStackView = UIStackView()
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    stackView.spacing = 0
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  private lazy var signInButton: UIButton = {
    let button = UIButton()
    button.setTitle(
      "Sign In",
      for: .normal
    )
    button.setTitleColor(
      .blue,
      for: .normal
    )
    button.addTarget(
      self,
      action: #selector(didTapSignInButton(_:)),
      for: .touchUpInside
    )
    return button
  }()
  private lazy var signUpButton: UIButton = {
    let button = UIButton()
    button.setTitle(
      "Sign up",
      for: .normal
    )
    button.setTitleColor(
      .blue,
      for: .normal
    )
    button.addTarget(
      self,
      action: #selector(didTapSignUpButton(_:)),
      for: .touchUpInside
    )
    return button
  }()
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    setupConstraints()
  }
}

extension SignInViewController {
  private func configureUI() {
    view.addSubviews(
      textFieldStackView,
      buttonStackView
    )
    
    textFieldStackView.addArrangeSubViews(
      IDTextField,
      passwordTextField
    )
    
    buttonStackView.addArrangeSubViews(
      signInButton,
      signUpButton
    )
  }
  
  private func setupConstraints() {
    [
      textFieldStackView.topAnchor.constraint(equalTo: view.topAnchor),
      textFieldStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      textFieldStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ]
      .forEach { $0.isActive = true }
    
    [
      buttonStackView.topAnchor.constraint(equalTo: textFieldStackView.bottomAnchor),
      buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      buttonStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ]
      .forEach { $0.isActive = true }
    
    [
      IDTextField.heightAnchor.constraint(equalToConstant: 44),
      passwordTextField.heightAnchor.constraint(equalToConstant: 44),
      signUpButton.heightAnchor.constraint(equalToConstant: 44),
      signInButton.heightAnchor.constraint(equalToConstant: 44)
    ]
      .forEach { $0.isActive = true }
  }
}

// MARK: - Selectors
extension SignInViewController {
  @objc private func didTapSignInButton(_ sender: UIButton) {
    delegate?.signIn()
  }
  
  @objc private func didTapSignUpButton(_ sender: UIButton) {
    delegate?.signUp()
  }
}

// MARK: - Private Functions
extension SignInViewController {
  private func setDelegates() {
    IDTextField.delegate = self
    passwordTextField.delegate = self
  }
}

extension SignInViewController: UITextFieldDelegate {
  
}
