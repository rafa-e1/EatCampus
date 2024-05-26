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
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setButtonActions()
    }
    
    // MARK: - Setup Navigation Bar Appearance
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.tintColor = .label
    }
    
    // MARK: - Actions
    
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
        
    }
    
    @objc private func createAccountButtonTapped() {
        let controller = RegistrationController()
        navigationController?.pushViewController(controller, animated: true)
    }
}
