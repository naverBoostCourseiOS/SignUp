//
//  ViewController.swift
//  SignUp
//
//  Created by hyosung on 2023/02/19.
//

import UIKit

final class LoggedOutViewController: UIViewController {
  
  // MARK: - UI Properties
  private let signInViewController: SignInViewController = {
    let viewController: SignInViewController = SignInViewController()
    viewController.view.translatesAutoresizingMaskIntoConstraints = false
    return viewController
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    setupConstraints()
    setupDelegates()
  }
}

extension LoggedOutViewController {
  private func configureUI() {
    addChild(signInViewController)
    signInViewController.didMove(toParent: self)
    
    view.addSubviews(
      signInViewController.view
    )
  }
  
  private func setupConstraints() {
    [
      signInViewController.view.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      signInViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
      signInViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
    ]
      .forEach { $0.isActive = true }
  }
}

extension LoggedOutViewController {
  private func setupDelegates() {
    signInViewController.delegate = self
  }
}

extension LoggedOutViewController: SignInViewControllerDelegate {
  func signIn() {
    
  }
  
  func signUp() {
    let signUpViewController = SignUpViewController()
    let navigationController = UINavigationController(rootViewController: signUpViewController)
    navigationController.navigationBar.isHidden = true
    navigationController.modalPresentationStyle = .overFullScreen
    present(navigationController, animated: true)
  }
}
