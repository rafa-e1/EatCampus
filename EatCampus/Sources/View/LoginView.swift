//
//  LoginView.swift
//  EatCampus
//
//  Created by RAFA on 5/25/24.
//

import UIKit

import SnapKit
import Then

final class LoginView: UIView {
    
    // MARK: - Properties
    
    private let appNameLabel = UILabel()
    
    private let emailTextField = AuthenticationTextField(placeholder: "이메일", isSecure: false)
    private let passwordTextField = AuthenticationTextField(placeholder: "비밀번호", isSecure: true)
    private let textFields = UIStackView()
    
    let loginButton = UIButton(type: .system)
    let resetPasswordButton = UIButton(type: .system)
    let createAccountButton = UIButton(type: .system)
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupConstraints()
        configureTextFieldDelegate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        endEditing(true)
    }
    
    // MARK: - Setup Views
    
    private func setupUI() {
        appNameLabel.do {
            $0.text = "맛집족보"
            $0.textAlignment = .center
            $0.font = .systemFont(ofSize: 40, weight: .heavy)
            addSubview($0)
        }
        
        loginButton.do {
            $0.authenticationButton(title: "로그인")
        }
        
        resetPasswordButton.do {
            $0.attributedTitle(
                firstPart: "비밀번호를 잊으셨나요? ", .secondaryLabel,
                secondPart: "비밀번호 재설정", .systemRed
            )
        }
        
        textFields.do {
            $0.axis = .vertical
            $0.spacing = 10
            $0.addArrangedSubview(emailTextField)
            $0.addArrangedSubview(passwordTextField)
            $0.addArrangedSubview(loginButton)
            $0.addArrangedSubview(resetPasswordButton)
            addSubview($0)
        }
        
        createAccountButton.do {
            $0.attributedTitle(
                firstPart: "계정이 없으신가요? ", .secondaryLabel,
                secondPart: "계정 생성하기", .systemBlue
            )
            addSubview($0)
        }
    }
    
    private func setupConstraints() {
        appNameLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(30)
            $0.left.equalTo(20)
        }
        
        textFields.snp.makeConstraints {
            $0.centerX.left.equalTo(appNameLabel)
            $0.top.equalTo(appNameLabel.snp.bottom).offset(30)
        }
        
        createAccountButton.snp.makeConstraints {
            $0.centerX.left.equalTo(textFields)
            $0.bottom.equalTo(keyboardLayoutGuide.snp.top)
        }
    }
}

// MARK: - UITextFieldDelegate

extension LoginView: UITextFieldDelegate {
    private func configureTextFieldDelegate() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            passwordTextField.resignFirstResponder()
        }
        
        return true
    }
}
