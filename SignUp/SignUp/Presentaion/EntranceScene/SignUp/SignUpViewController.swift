//
//  SignUpViewController.swift
//  SignUp
//
//  Created by 강동영 on 2023/02/19.
//

import UIKit

class SignUpViewController: UIViewController {

    static let identifier: String = String(describing: SignUpViewController.self)
    
    lazy var profilePicker: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        
        return picker
    }()
    
    let placeholderImage: UIImage? = UIImage(systemName: "text.below.photo.fill")?.withRenderingMode(.alwaysTemplate)
    
    var logoImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(systemName: "text.below.photo.fill")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()
    
    var idTextfield: UITextField = {
        let textfield = UITextField(frame: .zero)
        textfield.placeholder = "ID"
        textfield.borderStyle = .roundedRect
        
        return textfield
    }()
    
    var passwordTextfield: UITextField = {
        let textfield = UITextField(frame: .zero)
        textfield.placeholder = "Password"
        textfield.isSecureTextEntry = true
        textfield.borderStyle = .roundedRect
        
        return textfield
    }()
    
    var pwCheckTextfield: UITextField = {
        let textfield = UITextField(frame: .zero)
        textfield.placeholder = "Check Password"
        textfield.isSecureTextEntry = true
        textfield.borderStyle = .roundedRect
        
        return textfield
    }()
    
    var introduceTextView: UITextView = {
        let textView = UITextView(frame: .zero)
        textView.backgroundColor = .systemYellow
        
        return textView
    }()
    
    var cancelButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("취소", for: .normal)
        button.setTitleColor(.red, for: .normal)
        
        return button
    }()
    
    var nextButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("다음", for: .normal)
        button.setTitleColor(.tintColor, for: .normal)
        button.setTitleColor(.gray, for: .disabled)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initLayout()
        
        idTextfield.delegate = self
        passwordTextfield.delegate = self
        pwCheckTextfield.delegate = self
        introduceTextView.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(callPicker))
        logoImageView.addGestureRecognizer(tap)
        cancelButton.addTarget(self, action: #selector(touchCancelButton), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(touchNextButton), for: .touchUpInside)
        nextButton.isEnabled = false
    }

    private func initLayout() {
        
        let containerStackView: UIStackView = UIStackView(frame: .zero)
        containerStackView.axis = .vertical
        containerStackView.spacing = 10
        containerStackView.distribution = .fill
        containerStackView.alignment = .fill
        
        let headerStackView: UIStackView = UIStackView(frame: .zero)
        headerStackView.axis = .horizontal
        headerStackView.spacing = 0
        headerStackView.distribution = .fill
        headerStackView.alignment = .center
        
        let textFieldStackView: UIStackView = UIStackView(frame: .zero)
        textFieldStackView.axis = .vertical
        textFieldStackView.distribution = .fill
        textFieldStackView.alignment = .fill
        
        let buttonStackView: UIStackView = UIStackView(frame: .zero)
        buttonStackView.axis = .horizontal
        buttonStackView.spacing = 0
        buttonStackView.distribution = .fillEqually
        buttonStackView.alignment = .center
        
        headerStackView.addArrangedSubview(logoImageView)
        headerStackView.addArrangedSubview(textFieldStackView)
        
        textFieldStackView.addArrangedSubview(idTextfield)
        textFieldStackView.addArrangedSubview(passwordTextfield)
        textFieldStackView.addArrangedSubview(pwCheckTextfield)
        
        containerStackView.addArrangedSubview(headerStackView)
        containerStackView.addArrangedSubview(introduceTextView)
        containerStackView.addArrangedSubview(buttonStackView)
        
        buttonStackView.addArrangedSubview(cancelButton)
        buttonStackView.addArrangedSubview(nextButton)
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(containerStackView)
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            containerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            containerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            containerStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.widthAnchor.constraint(equalTo: logoImageView.heightAnchor, multiplier: 1.0),
        ])
    }
    
    @objc
    private func callPicker() {
        print(#function)
        
        present(profilePicker, animated: true, completion: nil)
    }
    
    @objc
    func touchCancelButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    func touchNextButton() {
        print(#function)
        
    }
    
    private func validNextStep() {
        guard logoImageView.image != placeholderImage else {
            nextButton.isEnabled = false
            return
        }
        
        guard
            idTextfield.text?.isEmpty == false,
            passwordTextfield.text?.isEmpty == false,
            pwCheckTextfield.text?.isEmpty == false
        else {
            nextButton.isEnabled = false
            return
        }
        
        guard introduceTextView.text.isEmpty == false else {
            nextButton.isEnabled = false
            return
        }
        
        nextButton.isEnabled = true
    }
}

// MARK: UIPickerViewDelegate Method
extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if picker.sourceType == .photoLibrary {
            DispatchQueue.main.async {
                self.logoImageView.image = info[.originalImage] as? UIImage
            }
            dismiss(animated: true)
        }
    }
}

// MARK: UITextFieldDelegate Method
extension SignUpViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        validNextStep()
    }
}

// MARK: UITextViewDelegate Method
extension SignUpViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        validNextStep()
    }
}
