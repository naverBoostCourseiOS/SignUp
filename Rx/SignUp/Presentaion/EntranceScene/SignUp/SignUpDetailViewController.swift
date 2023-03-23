//
//  SignUpDetailViewController.swift
//  SignUp
//
//  Created by 강동영 on 2023/02/22.
//

import UIKit

class SignUpDetailViewController: UIViewController {

    static let identifier: String = String(describing: SignUpDetailViewController.self)
    
    lazy var datePickerView: UIDatePicker = {
        let picker = UIDatePicker(frame: .zero)
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        picker.addTarget(self, action: #selector(onDidChangeDate(sender:)), for: .valueChanged)
        
        return picker
    }()
    
    lazy var birthValueLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.textAlignment = .right
        label.sizeToFit()
        
        return label
    }()
    
    
    lazy var cancelButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("취소", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(touchCancelButton), for: .touchUpInside)
        
        return button
    }()
    
    
    lazy var previousButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("이전", for: .normal)
        button.setTitleColor(.tintColor, for: .normal)
        button.addTarget(self, action: #selector(touchpPreviousButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var signUpButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("가입", for: .normal)
        button.setTitleColor(.tintColor, for: .normal)
        button.addTarget(self, action: #selector(touchSignUpButton), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initLayout()
    }
    
    private func initLayout() {
        
        let containerStackView: UIStackView = UIStackView(frame: .zero)
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        containerStackView.axis = .vertical
        containerStackView.spacing = 5
        containerStackView.distribution = .fill
        containerStackView.alignment = .fill
        
        let phoneNumberLabel: UILabel = UILabel(frame: .zero)
        phoneNumberLabel.text = "전화번호"
        phoneNumberLabel.textAlignment = .left
        
        let phoneNumberTextField: UITextField = UITextField(frame: .zero)
        phoneNumberTextField.placeholder = "datePickerView.date"
        print("datePickerView.date = \(datePickerView.date)")
        phoneNumberTextField.borderStyle = .roundedRect
        phoneNumberTextField.keyboardType = .numberPad
        
        let birthInfoView: UIView = UIView(frame: .zero)
        birthInfoView.backgroundColor = .clear
        birthInfoView.translatesAutoresizingMaskIntoConstraints = false
        
        let birthLabel: UILabel = UILabel(frame: .zero)
        birthLabel.translatesAutoresizingMaskIntoConstraints = false
        birthLabel.text = "생년월일"
        birthLabel.textAlignment = .left
        birthLabel.sizeToFit()
        
        birthInfoView.addSubview(birthLabel)
        birthInfoView.addSubview(birthValueLabel)
        
        let buttonStackView: UIStackView = UIStackView(frame: .zero)
        buttonStackView.axis = .horizontal
        buttonStackView.spacing = 0
        buttonStackView.distribution = .fillEqually
        buttonStackView.alignment = .center
        
        buttonStackView.addArrangedSubview(cancelButton)
        buttonStackView.addArrangedSubview(previousButton)
        buttonStackView.addArrangedSubview(signUpButton)
        
        containerStackView.addArrangedSubview(phoneNumberLabel)
        containerStackView.addArrangedSubview(phoneNumberTextField)
        containerStackView.addArrangedSubview(birthInfoView)
        containerStackView.addArrangedSubview(datePickerView)
        containerStackView.addArrangedSubview(buttonStackView)
        
        view.addSubview(containerStackView)
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            containerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            birthLabel.centerYAnchor.constraint(equalTo: birthInfoView.centerYAnchor),
            birthLabel.leadingAnchor.constraint(equalTo: birthInfoView.leadingAnchor),

            birthValueLabel.centerYAnchor.constraint(equalTo: birthInfoView.centerYAnchor),
            birthValueLabel.trailingAnchor.constraint(equalTo: birthInfoView.trailingAnchor),
        ])
    }
    
    @objc func onDidChangeDate(sender: UIDatePicker) {
        // Generate the format.
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd hh:mm"
        
        // Obtain the date according to the format.
        let selectedDate: String = dateFormatter.string(from: sender.date)
        self.birthValueLabel.text = selectedDate
    }
    
    @objc
    private func touchCancelButton() {
        
    }
    
    @objc
    private func touchpPreviousButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func touchSignUpButton() {
        
    }

}
