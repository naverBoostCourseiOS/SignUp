//
//  UserProfileViewController.swift
//  SignUp
//
//  Created by hyosung on 2023/02/19.
//

import UIKit

protocol UserProfileViewControllerDelegate: NSObject {
  func profileImageDidChanged(_ image: UIImage?)
  func IDTextFieldEditingDidChanged(_ text: String?)
  func passwordTextFieldEditingDidChanged(_ text: String?)
  func passwordConfirmTextFieldEditingDidChanged(_ text: String?)
  func profileDescriptionTextViewEditingDidChanged(_ text: String?)
}

final class UserProfileViewController: UIViewController {
  
  struct Dependency {
    let imagePickerService: ImagePickerServicable
  }
  
  // MARK: - Properties
  weak var delegate: UserProfileViewControllerDelegate?
  private let dependency: Dependency
  
  // MARK: - UI Properties
  private let userAuthenticationStackView: UIStackView = {
    let stackView: UIStackView = UIStackView()
    stackView.axis = .vertical
    stackView.distribution = .equalSpacing
    stackView.spacing = 10
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  private lazy var IDTextField: UITextField = {
    let textField: UITextField = UITextField()
    textField.placeholder = "ID"
    textField.textColor = .black
    textField.layer.cornerRadius = 5
    textField.layer.masksToBounds = true
    textField.layer.borderWidth = 1
    textField.layer.borderColor = UIColor.lightGray.cgColor
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.addTarget(
      self,
      action: #selector(
        IDTextFieldEditingDidChange(_:)),
      for: .editingChanged
    )
    return textField
  }()
  private lazy var passwordTextField :UITextField = {
    let textField: UITextField = UITextField()
    textField.placeholder = "Password"
    textField.isSecureTextEntry = true
    textField.textColor = .black
    textField.layer.cornerRadius = 5
    textField.layer.masksToBounds = true
    textField.layer.borderWidth = 1
    textField.layer.borderColor = UIColor.lightGray.cgColor
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.addTarget(
      self,
      action: #selector(
        passwordTextFieldEditingDidChange(_:)),
      for: .editingChanged
    )
    return textField
  }()
  private lazy var passwordConfirmTextField :UITextField = {
    let textField: UITextField = UITextField()
    textField.placeholder = "Password Confirmed"
    textField.isSecureTextEntry = true
    textField.textColor = .black
    textField.layer.cornerRadius = 5
    textField.layer.masksToBounds = true
    textField.layer.borderWidth = 1
    textField.layer.borderColor = UIColor.lightGray.cgColor
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.addTarget(
      self,
      action: #selector(
        passwordConfirmTextFieldEditingDidChange(_:)),
      for: .editingChanged
    )
    return textField
  }()
  private let userProfileStackView: UIStackView = {
    let stackView: UIStackView = UIStackView()
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    stackView.spacing = 10
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  private lazy var profileImageButton: UIButton = {
    let button: UIButton = UIButton()
    button.backgroundColor = .lightGray
    button.translatesAutoresizingMaskIntoConstraints = false
    button.addTarget(
      self,
      action: #selector(didTapProfileImageButton(_:)),
      for: .touchUpInside
    )
    return button
  }()
  private lazy var profileDescriptionTextView: UITextView = {
    let textView: UITextView = UITextView()
    textView.backgroundColor = .yellow
    textView.textColor = .black
    textView.translatesAutoresizingMaskIntoConstraints = false
    return textView
  }()
  
  init(_ dependency: Dependency) {
    self.dependency = dependency
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    setupConstraints()
    dependency.imagePickerService.setDelegate(self)
    profileDescriptionTextView.delegate = self
  }
}

extension UserProfileViewController {
  private func configureUI() {
    view.addSubviews(
      userProfileStackView,
      profileDescriptionTextView
    )
    
    userAuthenticationStackView.addArrangeSubViews(
      IDTextField,
      passwordTextField,
      passwordConfirmTextField
    )
    
    userProfileStackView.addArrangeSubViews(
      profileImageButton,
      userAuthenticationStackView
    )
  }
  
  private func setupConstraints() {
    [
      userProfileStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      userProfileStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      userProfileStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
    ]
      .forEach { $0.isActive = true }
    
    [
      profileDescriptionTextView.topAnchor.constraint(equalTo: userProfileStackView.bottomAnchor, constant: 10),
      profileDescriptionTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      profileDescriptionTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      profileDescriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
    ]
      .forEach { $0.isActive = true }
    
    [
      profileImageButton.widthAnchor.constraint(equalTo: profileImageButton.heightAnchor, multiplier: 1)
    ]
      .forEach { $0.isActive = true }
    
    [
      IDTextField.heightAnchor.constraint(equalToConstant: 44),
      passwordTextField.heightAnchor.constraint(equalToConstant: 44),
      passwordConfirmTextField.heightAnchor.constraint(equalToConstant: 44),
    ]
      .forEach { $0.isActive = true }
  }
}

extension UserProfileViewController: ImagePickerServiceDelegate {
  func didFinishPicking(_ image: UIImage?) {
    profileImageButton.setImage(image, for: .normal)
    delegate?.profileImageDidChanged(image)
  }
}

// MARK: - Selectors
extension UserProfileViewController {
  @objc private func didTapProfileImageButton(_ sender: UIButton) {
    dependency.imagePickerService.show(self)
  }

  @objc private func IDTextFieldEditingDidChange(_ textField: UITextField) {
    delegate?.IDTextFieldEditingDidChanged(textField.text)
  }
  
  @objc private func passwordTextFieldEditingDidChange(_ textField: UITextField) {
    delegate?.passwordTextFieldEditingDidChanged(textField.text)
  }
  
  @objc private func passwordConfirmTextFieldEditingDidChange(_ textField: UITextField) {
    delegate?.passwordConfirmTextFieldEditingDidChanged(textField.text)
  }
}

// MARK: - UITextView Delegate
extension UserProfileViewController: UITextViewDelegate {
  func textViewDidChange(_ textView: UITextView) {
    delegate?.profileDescriptionTextViewEditingDidChanged(textView.text)
  }
}
