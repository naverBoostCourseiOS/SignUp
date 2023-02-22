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
  
  struct Validation {
    var profileImage: Bool = false
    var ID: Bool = false
    var password: Bool = false
    var passwordConfirm: Bool = false
    var introduction: Bool = false
  }
  
  // MARK: - Properties
  
  private let dependency: Dependency
  private var validation = Validation() {
    didSet {
      checkAllValidation()
    }
  }
  
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
      action: #selector(didTapNextButton(_:)),
      for: .touchUpInside
    )
    button.translatesAutoresizingMaskIntoConstraints = false
    button.isEnabled = false
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
    setupDelegates()
  }
}

extension SignUpViewController {
  // MARK: - Configure UI
  private func configureUI() {
    view.backgroundColor = .white
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
  
  private func validateID(_ ID: String?) -> Bool {
    guard let ID = ID else { return false }
    do {
      return try dependency.IDRegexCalculator.calculate(ID)
    } catch {
      // TODO: - Error 처리
      return false
    }
  }
  
  private func validatePassword(_ password: String?) -> Bool {
    guard let password = password else { return false }
    do {
      return try dependency.passwordRegexCalculator.calculate(password)
    } catch {
      // TODO: - Error 처리
      return false
    }
  }
  
  private func checkAllValidation() {
    nextButton.isEnabled = validation.profileImage
    && validation.ID
    && validation.password
    && validation.passwordConfirm
    && validation.introduction
  }
}

// MARK: - Selectors
extension SignUpViewController {
  @objc private func didTapCancelButton(_ sender: UIButton) {
    UserInformation.shared.clear()
    navigationController?.popToRootViewController(animated: true)
  }
  
  @objc private func didTapNextButton(_ sender: UIButton) {
    
  }
}

extension SignUpViewController: UserProfileViewControllerDelegate {
  func profileImageDidChanged(_ image: UIImage?) {
    guard let profileIamge = image else { validation.profileImage = false; return }
    validation.profileImage = true
    UserInformation.shared.setProfileImage(profileIamge)
  }
  
  func IDTextFieldEditingDidChanged(_ text: String?) {
    guard validateID(text) else { validation.ID = false; return }
    validation.ID = true
    UserInformation.shared.setID(text ?? "")
  }
  
  func passwordTextFieldEditingDidChanged(_ text: String?) {
    guard validatePassword(text) else { validation.password = false; return }
    validation.password = true
    UserInformation.shared.setPassword(text ?? "")
  }
  
  func passwordConfirmTextFieldEditingDidChanged(_ text: String?) {
    guard validatePassword(text) else { validation.passwordConfirm = false; return }
    validation.passwordConfirm = true
  }
  
  func profileDescriptionTextViewEditingDidChanged(_ text: String?) {
    guard let introduction = text,
          !introduction.isEmpty else { validation.introduction = false; return }
    validation.introduction = true
    UserInformation.shared.setIntroduction(text ?? "")
  }
}
