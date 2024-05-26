//
//  RegistrationController.swift
//  EatCampus
//
//  Created by RAFA on 5/26/24.
//

import UIKit

final class RegistrationController: UIViewController {
    
    // MARK: - Properties
    
    private let registrationView = RegistrationView()
    private var viewModel = RegistrationViewModel()
    private var profileImage: UIImage?
    weak var delegate: AuthenticationDelegate?
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = registrationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setButtonActions()
        configureNotificationObservers()
    }
    
    // MARK: - Setup Navigation Bar Appearance
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Actions
    
    @objc private func handleProfilePhotoSelect() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    @objc private func textDidChange(sender: UITextField) {
        if sender == registrationView.nicknameTextField {
            viewModel.nickname = sender.text
        } else if sender == registrationView.fullnameTextField {
            viewModel.fullname = sender.text
        } else if sender == registrationView.emailTextField {
            viewModel.email = sender.text
        } else if sender == registrationView.passwordTextField {
            viewModel.password = sender.text
        } else {
            viewModel.confirmPassword = sender.text
        }
        
        updateForm()
    }
    
    @objc private func signUpButtonTapped() {
        guard let profileImage = self.profileImage else { return }
        guard let nickname = registrationView.nicknameTextField.text else { return }
        guard let fullname = registrationView.fullnameTextField.text else { return }
        guard let email = registrationView.emailTextField.text else { return }
        guard let password = registrationView.passwordTextField.text else { return }
        
        let credentials = AuthCredentials(
            profileImage: profileImage,
            nickname: nickname,
            fullname: fullname,
            email: email,
            password: password
        )
        
        AuthService.registerUser(withCredential: credentials) { error in
            if let error = error {
                print("DEBUG: Failed to register user: \(error.localizedDescription)")
                return
            }
            
            self.delegate?.authenticationDidComplete()
        }
    }
    
    private func setButtonActions() {
        registrationView.addPhotoButton.addTarget(
            self,
            action: #selector(handleProfilePhotoSelect),
            for: .touchUpInside
        )
        
        registrationView.signUpButton.addTarget(
            self,
            action: #selector(signUpButtonTapped),
            for: .touchUpInside
        )
    }
    
    private func configureNotificationObservers() {
        registrationView.nicknameTextField.addTarget(
            self,
            action: #selector(textDidChange),
            for: .editingChanged
        )
        
        registrationView.fullnameTextField.addTarget(
            self,
            action: #selector(textDidChange),
            for: .editingChanged
        )
        
        registrationView.emailTextField.addTarget(
            self,
            action: #selector(textDidChange),
            for: .editingChanged
        )
        
        registrationView.passwordTextField.addTarget(
            self,
            action: #selector(textDidChange),
            for: .editingChanged
        )
        
        registrationView.confirmPasswordTextField.addTarget(
            self,
            action: #selector(textDidChange),
            for: .editingChanged
        )
    }
}

// MARK: - FormViewModel

extension RegistrationController: FormViewModel {
    func updateForm() {
        UIView.animate(withDuration: 0.5) {
            self.registrationView.signUpButton.backgroundColor = 
            self.viewModel.buttonBackgroundColor
            
            self.registrationView.signUpButton.isEnabled = self.viewModel.isFormValid
        }
        
        UIView.transition(
            with: registrationView.signUpButton,
            duration: 0.5,
            options: .transitionCrossDissolve
        ) {
            self.registrationView.signUpButton.setTitleColor(
                self.viewModel.buttonTitleColor,
                for: .normal
            )
        }
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate

extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        profileImage = selectedImage
        registrationView.addPhotoButton.layer.cornerRadius = 
        registrationView.addPhotoButton.frame.width / 2
        registrationView.addPhotoButton.layer.masksToBounds = true
        registrationView.addPhotoButton.layer.borderWidth = 2
        registrationView.addPhotoButton.layer.borderColor = UIColor.systemGreen.cgColor
        registrationView.addPhotoButton.setImage(
            selectedImage.withRenderingMode(.alwaysOriginal),
            for: .normal
        )
        dismiss(animated: true)
    }
}
