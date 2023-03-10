//
//  AdditionalInfoViewController.swift
//  SignUp
//
//  Created by Doyeon on 2023/02/19.
//

import UIKit

class AdditionalInfoViewController: UIViewController {
    
    // MARK: - Properties
    var labelStackView: UIStackView!
    var buttonStackView: UIStackView!
    
    var phoneNumberLabel: UILabel!
    var phoneNumberTextField: UITextField!
    
    var birtydayLabel: UILabel!
    var dateOfBirthLabel: UILabel!
    var datePicker: UIDatePicker!
    
    var previousBtn: UIButton!
    var cancelBtn: UIButton!
    var signUpBtn: UIButton!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }
}

extension AdditionalInfoViewController {
    // MARK: - Methods
    func setupViews() {

        phoneNumberLabel = makeTextLabel(text: "전화번호", size: 22, type: .SemiBold)
        
        phoneNumberTextField = makeTextField(withPlaceholder: "01012345678", isSecureTextEntry: false)
        phoneNumberTextField.keyboardType = .phonePad
        
        birtydayLabel = makeTextLabel(text: "생년월일", size: 22, type: .SemiBold)
        dateOfBirthLabel = makeTextLabel(text: "2023.01.01", size: 20, type: .Regular)
        dateOfBirthLabel.textColor = .black
        
        labelStackView = makeStackView(arrangedSubviews: [birtydayLabel, dateOfBirthLabel], axis: .horizontal, spacing: 40)
        
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action: #selector(datePickerDidChange), for: .valueChanged)
        
        previousBtn = makeButton(withTitle: "이전", titleColor: .systemBlue)
        cancelBtn = makeButton(withTitle: "취소", titleColor: .systemRed)
        signUpBtn = makeButton(withTitle: "가입", titleColor: .systemBlue)
        
        buttonStackView = makeStackView(arrangedSubviews: [cancelBtn, previousBtn, signUpBtn], axis: .horizontal, spacing: 40)
        
        let views: [UIView] = [phoneNumberLabel, phoneNumberTextField, labelStackView, datePicker, buttonStackView]
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }

        NSLayoutConstraint.activate([
            phoneNumberLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            phoneNumberLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            phoneNumberLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            phoneNumberLabel.heightAnchor.constraint(equalToConstant: 40),
            
            phoneNumberTextField.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor, constant: 20),
            phoneNumberTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            phoneNumberTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            phoneNumberTextField.heightAnchor.constraint(equalToConstant: 40),
            
            labelStackView.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: 40),
            labelStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            labelStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            labelStackView.heightAnchor.constraint(equalToConstant: 40),
            
            datePicker.topAnchor.constraint(equalTo: labelStackView.bottomAnchor, constant: 20),
            datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            datePicker.heightAnchor.constraint(equalToConstant: 100),
            
            buttonStackView.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 40),
            buttonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    // MARK: @objc
    @objc func datePickerDidChange(_ datePicker: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        dateOfBirthLabel.text = formatter.string(from: datePicker.date)
    }
    
}
