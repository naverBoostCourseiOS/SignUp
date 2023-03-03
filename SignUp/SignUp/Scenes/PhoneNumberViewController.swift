//
//  PhoneNumberViewController.swift
//  SignUp
//
//  Created by hyosung on 2023/02/22.
//

import UIKit

protocol PhoneNumberViewControllerDelegate: NSObject {
  func phoneNumberDidChanged(_ text: String?)
}

final class PhoneNumberViewController: UIViewController {
  
  // MARK: - Properties
  weak var delegate: PhoneNumberViewControllerDelegate?
  
  // MARK: - UI Properties
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "전화번호"
    label.textColor = .black
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  private lazy var phoneNumberTextField: UITextField = {
    let textField: UITextField = UITextField()
    textField.keyboardType = .namePhonePad
    textField.placeholder = "전화번호"
    textField.textColor = .black
    textField.layer.cornerRadius = 5
    textField.layer.masksToBounds = true
    textField.layer.borderWidth = 1
    textField.layer.borderColor = UIColor.lightGray.cgColor
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.addTarget(
      self,
      action: #selector(
        phoneNumberTextFieldEditingDidChange(_:)),
      for: .editingChanged
    )
    return textField
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    setupConstraints()
  }
}

extension PhoneNumberViewController {
  private func configureUI() {
    view.addSubviews(
      titleLabel,
      phoneNumberTextField
    )
  }
  
  private func setupConstraints() {
    [
      titleLabel.topAnchor.constraint(equalTo: view.topAnchor),
      titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ]
      .forEach { $0.isActive = true }
    
    [
      phoneNumberTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
      phoneNumberTextField.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      phoneNumberTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      phoneNumberTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      phoneNumberTextField.heightAnchor.constraint(equalToConstant: 44)
    ]
      .forEach { $0.isActive = true }
  }
}

// MARK: - Selectors
extension PhoneNumberViewController {
  @objc private func phoneNumberTextFieldEditingDidChange(_ textField: UITextField) {
    delegate?.phoneNumberDidChanged(textField.text)
  }
}
