//
//  LoginController.swift
//  EatCampus
//
//  Created by RAFA on 5/25/24.
//

import UIKit

import FirebaseAuth

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
        
        showLoadingIndicator(true)
        
        AuthService.logUserIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to register user: \(error.localizedDescription)")
                self.showLoadingIndicator(false)
                self.showAlert(title: "로그인 실패", message: "이메일 또는 비밀번호 오류")
                return
            }
            
            self.delegate?.authenticationDidComplete()
        }
    }
    
    @objc private func resetPasswordButtonTapped() {
        let alertController = UIAlertController(
            title: "비밀번호 재설정",
            message: "등록된 이메일 주소를 입력해주세요.",
            preferredStyle: .alert
        )
        
        alertController.addTextField { textField in
            textField.placeholder = "이메일"
            textField.keyboardType = .emailAddress
        }
        
        let confirmAction = UIAlertAction(
            title: "확인",
            style: .default
        ) { [weak alertController] _ in
            guard let alertController = alertController, let email = alertController.textFields?.first?.text, !email.isEmpty else {
                self.showAlert(title: "오류", message: "이메일 주소를 입력해야 합니다.")
                return
            }
            
            self.sendPasswordResetEmail(to: email)
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }

    private func sendPasswordResetEmail(to email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                self.showAlert(title: "오류", message: "비밀번호 재설정 이메일 전송에 실패했습니다: \(error.localizedDescription)")
            } else {
                self.showAlert(title: "성공", message: "비밀번호 재설정 이메일이 전송되었습니다.")
            }
        }
    }
    
    @objc private func createAccountButtonTapped() {
        let controller = RegistrationController()
        controller.delegate = delegate
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func showLoadingIndicator(_ show: Bool) {
        UIView.animate(withDuration: 0.2) {
            if show {
                self.loginView.activityIndicator.startAnimating()
            } else {
                self.loginView.activityIndicator.stopAnimating()
            }
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
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
