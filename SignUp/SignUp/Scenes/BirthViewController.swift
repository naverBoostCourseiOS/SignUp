//
//  BirthViewController.swift
//  SignUp
//
//  Created by hyosung on 2023/02/22.
//

import UIKit

protocol BirthViewControllerDelegate: NSObject {
  func pickerViewDidChange(_ date: Date)
}

final class BirthViewController: UIViewController {
  // MARK: - Properties
  weak var delegate: BirthViewControllerDelegate?
  
  // MARK: - UI Properties
  private let titleStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .horizontal
    stackView.distribution = .equalSpacing
    stackView.spacing = 10
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "생년월일"
    label.textColor = .black
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  private let birthLabel: UILabel = {
    let label = UILabel()
    label.textColor = .black
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  private lazy var pickerView: UIDatePicker = {
    let pickerView = UIDatePicker()
    pickerView.datePickerMode = .date
    pickerView.preferredDatePickerStyle = .wheels
    pickerView.locale = .current
    pickerView.translatesAutoresizingMaskIntoConstraints = false
    pickerView.addTarget(
      self,
      action: #selector(pickerViewDidChange),
      for: .valueChanged
    )
    return pickerView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    setupConstraints()
  }
}

extension BirthViewController {
  private func configureUI() {
    view.addSubviews(
      titleStackView,
      pickerView
    )
    
    titleStackView.addArrangeSubViews(
      titleLabel,
      birthLabel
    )
  }
  
  private func setupConstraints() {
    [
      titleStackView.topAnchor.constraint(equalTo: view.topAnchor),
      titleStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      titleStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ]
      .forEach { $0.isActive = true }
    
    [
      pickerView.topAnchor.constraint(equalTo: titleStackView.bottomAnchor),
      pickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      pickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      pickerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ]
      .forEach { $0.isActive = true }
  }
}

extension BirthViewController: UIPickerViewDelegate {
  @objc private func pickerViewDidChange(_ sender: UIDatePicker) {
    birthLabel.text = "\(sender.date)"
    delegate?.pickerViewDidChange(sender.date)
  }
}
