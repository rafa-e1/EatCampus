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
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = registrationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        configureNotificationObservers()
    }
    
    // MARK: - Setup Navigation Bar Appearance
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Actions
    
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
