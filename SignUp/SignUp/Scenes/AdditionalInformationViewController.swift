//
//  AdditionalInformationViewController.swift
//  SignUp
//
//  Created by hyosung on 2023/02/26.
//

import UIKit

final class AdditionalInformationViewController: UIViewController {
  struct Dependency {
    let phoneRegexCalculator: PhoneRegexCalculatable
  }
  
  struct Validation {
    var phone: Bool = false
    var birth: Bool = false
  }
  
  // MARK: - Properties
  private let dependency: Dependency
  private var validation = Validation() {
    didSet {
      checkAllValidation()
    }
  }
  
  // MARK: - UI Properties
  private let phoneNumberViewController: PhoneNumberViewController = {
    let viewController = PhoneNumberViewController()
    viewController.view.translatesAutoresizingMaskIntoConstraints = false
    return viewController
  }()
  private let birthViewController: BirthViewController = {
    let viewController = BirthViewController()
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
  private lazy var signUpButton: UIButton = {
    let button = UIButton()
    button.setTitle(
      "가입",
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
  }
}

extension AdditionalInformationViewController {
  private func configureUI() {
    addChild(phoneNumberViewController)
    addChild(birthViewController)
    
    phoneNumberViewController.didMove(toParent: self)
    birthViewController.didMove(toParent: self)
    
    phoneNumberViewController.delegate = self
    
    view.addSubviews(
      phoneNumberViewController.view,
      birthViewController.view,
      buttonStackView
    )
    
    buttonStackView.addArrangeSubViews(
      cancelButton,
      signUpButton
    )
  }
  
  private func setupConstraints() {
   [
    phoneNumberViewController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
    phoneNumberViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
    phoneNumberViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
   ]
      .forEach { $0.isActive = true }
    
    [
      birthViewController.view.topAnchor.constraint(equalTo: phoneNumberViewController.view.bottomAnchor, constant: 10),
      birthViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      birthViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
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

// MARK: - Private Function
extension AdditionalInformationViewController {
  private func checkAllValidation() {
    signUpButton.isEnabled = validation.phone
    && validation.birth
  }
  
  private func validatePhone(_ text: String) -> Bool {
    do {
      return try dependency.phoneRegexCalculator.calculate(text)
    } catch {
      return false
    }
  }
}

// MARK: - Selectors
extension AdditionalInformationViewController {
  @objc private func didTapCancelButton(_ sender: UIButton) {
    navigationController?.popViewController(animated: true)
  }
  
  @objc private func didTapSignUpButton(_ sender: UIButton) {
    navigationController?.popToRootViewController(animated: true)
  }
}

// MARK: - PhoneNumberViewControllerDelegate
extension AdditionalInformationViewController: PhoneNumberViewControllerDelegate {
  func phoneNumberDidChanged(_ text: String?) {
    guard let text = text,
          validatePhone(text) else { validation.phone = false; return }
    validation.phone = true
    UserInformation.shared.setPhone(text)
  }
}

extension AdditionalInformationViewController: BirthViewControllerDelegate {
  func pickerViewDidChange(_ date: Date) {
    validation.birth = true
    UserInformation.shared.setBirth(date)
  }
}
