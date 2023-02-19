//
//  SignUpViewController.swift
//  SignUp
//
//  Created by hyosung on 2023/02/19.
//

import UIKit

final class SignUpViewController: UIViewController {
  
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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    setupConstraints()
  }
}

extension SignUpViewController {
  private func configureUI() {
    addChild(userProfileViewController)
    userProfileViewController.didMove(toParent: self)
    
    view.addSubviews(
      userProfileViewController.view
    )
  }
  
  private func setupConstraints() {
    [
      userProfileViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
      userProfileViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      userProfileViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      userProfileViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ]
      .forEach { $0.isActive = true }
  }
}

extension SignUpViewController {
  private func setupDelegates() {
    userProfileViewController.delegate = self
  }
}

extension SignUpViewController: UserProfileViewControllerDelegate {
  func cancel() {
    
  }
  
  func next() {
    
  }
}
