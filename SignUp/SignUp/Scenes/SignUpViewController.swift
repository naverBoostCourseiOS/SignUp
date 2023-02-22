//
//  SignUpViewController.swift
//  SignUp
//
//  Created by hyosung on 2023/02/19.
//

import UIKit

final class SignUpViewController: UIViewController {
  
  struct Dependency {
    let IDRegexCalculator: IDRegexCalculatable
    let passwordRegexCalculator: PasswordRegexCalculatable
  }
  
  // MARK: - Properties
  
  private let dependency: Dependency
  
  // MARK: - UI Properties
  private let userProfileViewController: UserProfileViewController = {
    let viewController: UserProfileViewController = UserProfileViewController(
      .init(
        imagePickerService: ImagePickerService()
      )
    )
    viewController.view.translatesAutoresizingMaskIntoConstraints = false
    return viewController
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
  }
}

extension SignUpViewController {
  // MARK: - Configure UI
  private func configureUI() {
    addChild(userProfileViewController)
    userProfileViewController.didMove(toParent: self)
    
    view.addSubviews(
      userProfileViewController.view,
      buttonStackView
    )
    
    buttonStackView.addArrangeSubViews(
      cancelButton,
      nextButton
    )
  }

  // MARK: - Setup Constraints
  private func setupConstraints() {
    [
      userProfileViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
      userProfileViewController.view.bottomAnchor.constraint(equalTo: buttonStackView.topAnchor, constant: -10),
      userProfileViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      userProfileViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ]
      .forEach { $0.isActive = true }
    
    [
      buttonStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      buttonStackView.heightAnchor.constraint(equalToConstant: 44)
    ]
      .forEach { $0.isActive = true }
  }
}

// MARK: - Private Functions
extension SignUpViewController {
  private func setupDelegates() {
    userProfileViewController.delegate = self
  }
}

// MARK: - Selectors
extension SignUpViewController {
  @objc private func didTapCancelButton(_ sender: UIButton) {
    
  }
  
  @objc private func didTapOKButton(_ sender: UIButton) {
    
  }
}

extension SignUpViewController: UserProfileViewControllerDelegate {
  func IDTextFieldEditingDidChanged(_ text: String?) {
  }
  
  func passwordTextFieldEditingDidChanged(_ text: String?) {
  }
  
  func passwordConfirmTextFieldEditingDidChanged(_ text: String?) {
  }
  
  func profileDescriptionTextViewEditingDidChanged(_ text: String?) {
  }
}
