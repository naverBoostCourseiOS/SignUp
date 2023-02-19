//
//  UserProfileViewController.swift
//  SignUp
//
//  Created by hyosung on 2023/02/19.
//

import UIKit

protocol UserProfileViewControllerDelegate: NSObject {
  func cancel()
  func next()
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
  private let IDTextField: UITextField = {
    let textField: UITextField = UITextField()
    textField.placeholder = "ID"
    textField.textColor = .black
    textField.layer.cornerRadius = 5
    textField.layer.masksToBounds = true
    textField.layer.borderWidth = 1
    textField.layer.borderColor = UIColor.lightGray.cgColor
    textField.translatesAutoresizingMaskIntoConstraints = false
    return textField
  }()
  private let passwordTextField :UITextField = {
    let textField: UITextField = UITextField()
    textField.placeholder = "Password"
    textField.isSecureTextEntry = true
    textField.textColor = .black
    textField.layer.cornerRadius = 5
    textField.layer.masksToBounds = true
    textField.layer.borderWidth = 1
    textField.layer.borderColor = UIColor.lightGray.cgColor
    textField.translatesAutoresizingMaskIntoConstraints = false
    return textField
  }()
  private let passwordConfirmTextField :UITextField = {
    let textField: UITextField = UITextField()
    textField.placeholder = "Password Confirmed"
    textField.isSecureTextEntry = true
    textField.textColor = .black
    textField.layer.cornerRadius = 5
    textField.layer.masksToBounds = true
    textField.layer.borderWidth = 1
    textField.layer.borderColor = UIColor.lightGray.cgColor
    textField.translatesAutoresizingMaskIntoConstraints = false
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
  private let profileDescriptionTextView: UITextView = {
    let textView: UITextView = UITextView()
    textView.backgroundColor = .yellow
    textView.textColor = .black
    textView.translatesAutoresizingMaskIntoConstraints = false
    return textView
  }()
  private let buttonStackView: UIStackView = {
    let stackView: UIStackView = UIStackView()
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    stackView.spacing = 0
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  private lazy var cancelButton: UIButton = {
    let button = UIButton()
    button.setTitle(
      "취소",
      for: .normal
    )
    button.setTitleColor(
      .red,
      for: .normal
    )
    button.addTarget(
      self,
      action: #selector(didTapCancelButton(_:)),
      for: .touchUpInside
    )
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  private lazy var nextButton: UIButton = {
    let button = UIButton()
    button.setTitle(
      "다음",
      for: .normal
    )
    button.setTitleColor(
      .blue,
      for: .normal
    )
    button.addTarget(
      self,
      action: #selector(didTapOKButton(_:)),
      for: .touchUpInside
    )
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
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
  }
}

extension UserProfileViewController {
  private func configureUI() {
    view.addSubviews(
      userProfileStackView,
      profileDescriptionTextView,
      buttonStackView
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
    
    buttonStackView.addArrangeSubViews(
      cancelButton,
      nextButton
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
      profileDescriptionTextView.bottomAnchor.constraint(equalTo: buttonStackView.topAnchor, constant: -20)
    ]
      .forEach { $0.isActive = true }
    
    [
      buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      buttonStackView.heightAnchor.constraint(equalToConstant: 44)
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

// MARK: - Selectors
extension UserProfileViewController {
  @objc private func didTapProfileImageButton(_ sender: UIButton) {
    dependency.imagePickerService.show(self)
  }
  @objc private func didTapCancelButton(_ sender: UIButton) {
    delegate?.cancel()
  }
  
  @objc private func didTapOKButton(_ sender: UIButton) {
    delegate?.next()
  }
}

extension UserProfileViewController: ImagePickerServiceDelegate {
  func didFinishPicking(_ image: UIImage?) {
    profileImageButton.setImage(image, for: .normal)
  }
}
