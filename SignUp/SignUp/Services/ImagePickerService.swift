//
//  ImagePickerService.swift
//  SignUp
//
//  Created by hyosung on 2023/02/19.
//

import PhotosUI

protocol ImagePickerServiceDelegate: NSObject {
  func didFinishPicking(_ image: UIImage?)
}

protocol ImagePickerServicable {
  func show(_ viewController: UIViewController)
  func setDelegate(_ self: ImagePickerServiceDelegate)
}

final class ImagePickerService: ImagePickerServicable {
  
  // MARK: - Properties
  weak var delegate: ImagePickerServiceDelegate?
  
  private let imagePickerController: PHPickerViewController = {
    var configuration: PHPickerConfiguration = PHPickerConfiguration()
    configuration.filter = .any(of: [.images])
    let imagePickerController: PHPickerViewController = PHPickerViewController(configuration: configuration)
    return imagePickerController
  }()
  
  init() {
    imagePickerController.delegate = self
  }
}

extension ImagePickerService {
  func show(_ viewController: UIViewController) {
    viewController.present(imagePickerController, animated: true)
  }
  
  func setDelegate(_ self: ImagePickerServiceDelegate) {
    delegate = self
  }
}

extension ImagePickerService: PHPickerViewControllerDelegate {
  func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
    guard let itemProvider = results.first?.itemProvider else { return }
    guard itemProvider.canLoadObject(ofClass: UIImage.self) else { return }
    imagePickerController.dismiss(animated: true)
    
    itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
      guard let self = self else { return }
      DispatchQueue.main.async {
        self.delegate?.didFinishPicking(image as? UIImage)
      }
    }
  }
}
