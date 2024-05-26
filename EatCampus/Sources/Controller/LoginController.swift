//
//  LoginController.swift
//  EatCampus
//
//  Created by RAFA on 5/25/24.
//

import UIKit

protocol AuthenticationDelegate: AnyObject {
    func authenticationDidComplete()
}

final class LoginController: UIViewController {
    
    // MARK: - Properties
    
    private let loginView = LoginView()
    private var viewModel = LoginViewModel()
    weak var delegate: AuthenticationDelegate?
    
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
        guard let email = loginView.emailTextField.text else { return }
        guard let password = loginView.passwordTextField.text else { return }
        
        AuthService.logUserIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to register user: \(error.localizedDescription)")
                return
            }
            
            self.delegate?.authenticationDidComplete()
        }
    }
    
    @objc private func resetPasswordButtonTapped() {
        print("비밀번호 재설정 이메일 전송")
    }
    
    @objc private func createAccountButtonTapped() {
        let controller = RegistrationController()
        controller.delegate = delegate
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
