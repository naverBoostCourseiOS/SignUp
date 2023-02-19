//
//  SignUpViewController.swift
//  SignUp
//
//  Created by Doyeon on 2023/02/18.
//

import UIKit
import AVFoundation
import Photos

class SignUpViewController: UIViewController {
    
    // MARK: - Properties
    var textFieldStackView: UIStackView!
    var buttonStackView: UIStackView!
    var topStackView: UIStackView!
    
    var imageView: UIImageView!
    var idTextField: UITextField!
    var pwTextField: UITextField!
    var pwCheckTextField: UITextField!
    var textView: UITextView!
    
    var cancelBtn: UIButton!
    var nextBtn: UIButton!

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }
}

extension SignUpViewController {

    // MARK: - Methods
    func setupViews() {
        imageView = makeImageView(name: "No Image")
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped))
        imageView.addGestureRecognizer(tapGesture)
        imageView.isUserInteractionEnabled = true

        idTextField = makeTextField(withPlaceholder: "ID", isSecureTextEntry: false)
        pwTextField = makeTextField(withPlaceholder: "Password", isSecureTextEntry: true)
        pwCheckTextField = makeTextField(withPlaceholder: "Password Check", isSecureTextEntry: true)
        
        textView = UITextView()
        textView.font = UIFont.Pretendard(type: .Regular, size: 20)
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        textView.text = "자기소개"
        textView.backgroundColor = UIColor(red: 0.95, green: 0.79, blue: 0.27, alpha: 1.00)
        
        cancelBtn = makeButton(withTitle: "취소", titleColor: .systemRed)
        nextBtn = makeButton(withTitle: "다음", titleColor: .systemBlue)
        
        textFieldStackView = makeStackView(arrangedSubviews: [idTextField, pwTextField, pwCheckTextField], axis: .vertical, spacing: 16)
        topStackView = makeStackView(arrangedSubviews: [imageView, textFieldStackView], axis: .horizontal, spacing: 26)
        buttonStackView = makeStackView(arrangedSubviews: [cancelBtn, nextBtn], axis: .horizontal, spacing: 140)
        
        let views = [imageView, textView, topStackView, buttonStackView]
        views.forEach {
            $0!.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0!)
        }
        view.bringSubviewToFront(imageView)
        
        NSLayoutConstraint.activate([
            imageView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100),

            textFieldStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            textFieldStackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            textFieldStackView.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 20),
            
            topStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            topStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            textView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            textView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            textView.heightAnchor.constraint(equalToConstant: 300),
            textView.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 40),
            
            buttonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonStackView.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 40)
        ])

        cancelBtn.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        nextBtn.addTarget(self, action: #selector(tappedNext(_:)), for: .touchUpInside)
    }
    
    func checkCameraPermission() {
        AVCaptureDevice.requestAccess(for: .video) { (granted: Bool) in
            if granted {
                print("Camera : 권한 허용")
            } else {
                print("Camera : 권한 거부")
            }
        }
    }
    
    func checkAlbumPermission() {
        PHPhotoLibrary.requestAuthorization { status in
            switch status {
            case .notDetermined:
                print("Album : The user hasn’t set the app’s authorization status.")
            case .restricted:
                print("Album : The app isn’t authorized to access the photo library, and the user can’t grant such permission.")
            case .denied:
                print("Album : The user explicitly denied this app access to the photo library.")
            case .authorized:
                print("Album : The user explicitly granted this app access to the photo library.")
            case .limited:
                print("Album : The user authorized this app for limited photo library access.")
            default:
                break
            }
        }
    }
    
    private func isValidInput() -> Bool {
        
        guard let id = idTextField.text, !id.isEmpty else {
            showErrorAlert(with: .idEmpty)
            return false
        }
        
        guard let pw = pwTextField.text, !pw.isEmpty else {
            showErrorAlert(with: .pwEmpty)
            return false
        }
        
        guard let pwCheck = pwCheckTextField.text, !pwCheck.isEmpty else {
            showErrorAlert(with: .pwCheck)
            return false
        }
        
        guard pw == pwCheck else {
            showErrorAlert(with: .pwMismatch)
            return false
        }
        
        return true
    }
    
    // MARK: @objc
    @objc func cancelButtonTapped() {
        idTextField.text = ""
        pwTextField.text = ""
        pwCheckTextField.text = ""
        textView.text = ""
        
        dismiss(animated: true)
    }
    
    @objc func imageViewTapped() {
        checkCameraPermission()
        checkAlbumPermission()
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func tappedNext(_ sender: UIButton) {
        if isValidInput() {
            print("전부 입력 완료")
            
            // TODO: 다음 화면으로 넘어가기
            UserInformation.shared.saveBasicInfo(id: idTextField.text, pw: pwTextField.text, introduction: textView.text)
            
        } else {
            let alert = UIAlertController(title: nil, message: "아직 입력하지 않은 항목이 있습니다.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            present(alert, animated: true)
        }
    }
    
    private func showErrorAlert(with error: InputError) {
        let alert = UIAlertController(title: nil, message: error.message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }

}

extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            imageView.image = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = originalImage
        }
        
        dismiss(animated: true)
    }
}

enum InputError: Error {
    case idEmpty
    case pwEmpty
    case pwCheck
    case pwMismatch
    
    var message: String {
        switch self {
        case .idEmpty:
            return "아이디를 입력해주세요."
        case .pwEmpty:
            return "비밀번호를 입력해주세요."
        case .pwCheck:
            return "비밀번호를 한번 더 입력해주세요."
        case .pwMismatch:
            return "비밀번호가 일치하지 않습니다."
        }
    }
}
