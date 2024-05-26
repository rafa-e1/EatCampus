//
//  LoginController.swift
//  EatCampus
//
//  Created by RAFA on 5/25/24.
//

import UIKit

final class LoginController: UIViewController {
    
    // MARK: - Properties
    
    private let loginView = LoginView()
    private var viewModel = LoginViewModel()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setButtonActions()
        configureNotificationObservers()
    }
    
    // MARK: - Setup Navigation Bar Appearance
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.tintColor = .label
    }
    
    // MARK: - Actions
    
    @objc private func textDidChange(sender: UITextField) {
        if sender == loginView.emailTextField {
            viewModel.email = sender.text
        } else {
            viewModel.password = sender.text
        }
        
        updateForm()
    }
    
    private func configureNotificationObservers() {
        loginView.emailTextField.addTarget(
            self,
            action: #selector(textDidChange),
            for: .editingChanged
        )
        
        loginView.passwordTextField.addTarget(
            self,
            action: #selector(textDidChange),
            for: .editingChanged
        )
    }
    
    private func setButtonActions() {
        loginView.loginButton.addTarget(
            self,
            action: #selector(loginButtonTapped),
            for: .touchUpInside
        )
        
        loginView.resetPasswordButton.addTarget(
            self,
            action: #selector(resetPasswordButtonTapped),
            for: .touchUpInside
        )
        
        loginView.createAccountButton.addTarget(
            self,
            action: #selector(createAccountButtonTapped),
            for: .touchUpInside
        )
    }
    
    @objc private func loginButtonTapped() {
        
    }
    
    @objc private func resetPasswordButtonTapped() {
        print("비밀번호 재설정 이메일 전송")
    }
    
    @objc private func createAccountButtonTapped() {
        let controller = RegistrationController()
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: - FormViewModel

extension LoginController: FormViewModel {
    func updateForm() {
        UIView.animate(withDuration: 0.5) {
            self.loginView.loginButton.backgroundColor =
            self.viewModel.buttonBackgroundColor
            
            self.loginView.loginButton.isEnabled = self.viewModel.isFormValid
        }
        
        UIView.transition(
            with: loginView.loginButton,
            duration: 0.5,
            options: .transitionCrossDissolve
        ) {
            self.loginView.loginButton.setTitleColor(
                self.viewModel.buttonTitleColor,
                for: .normal
            )
        }
    }
}
