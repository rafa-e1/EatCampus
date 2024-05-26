//
//  RegistrationView.swift
//  EatCampus
//
//  Created by RAFA on 5/26/24.
//

import UIKit

import SnapKit
import Then

final class RegistrationView: UIView {
    
    // MARK: - Properties
    
    private let addPhotoButton = UIButton(type: .system)
    
    let nicknameTextField = AuthenticationTextField(placeholder: "닉네임", isSecure: false)
    let fullnameTextField = AuthenticationTextField(placeholder: "이름", isSecure: false)
    private let nameStackView = UIStackView()
    
    let emailTextField = AuthenticationTextField(placeholder: "이메일", isSecure: false)
    let passwordTextField = AuthenticationTextField(placeholder: "비밀번호", isSecure: true)
    let confirmPasswordTextField = AuthenticationTextField(placeholder: "비밀번호 확인", isSecure: true)
    let signUpButton = UIButton(type: .system)
    private let credentialsStackView = UIStackView()
    
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
    
    // MARK: - Setup Views
    
    private func setupUI() {
        backgroundColor = .background
        
        addPhotoButton.do {
            $0.setBackgroundImage(
                UIImage(systemName: "person.circle.fill")?
                    .withTintColor(.buttonBackground, renderingMode: .alwaysOriginal), for: .normal
            )
            
            $0.setImage(
                UIImage(systemName: "plus")?
                    .withTintColor(.systemBlue, renderingMode: .alwaysOriginal)
                    .withConfiguration(
                        UIImage.SymbolConfiguration(pointSize: 30, weight: .light)
                    ),
                for: .normal
            )
            
            addSubview($0)
        }
        
        nameStackView.do {
            $0.axis = .vertical
            $0.spacing = 10
            $0.addArrangedSubview(nicknameTextField)
            $0.addArrangedSubview(fullnameTextField)
            addSubview($0)
        }
        
        signUpButton.do {
            $0.authenticationButton(title: "회원가입")
        }
        
        credentialsStackView.do {
            $0.axis = .vertical
            $0.spacing = 10
            $0.addArrangedSubview(emailTextField)
            $0.addArrangedSubview(passwordTextField)
            $0.addArrangedSubview(confirmPasswordTextField)
            $0.addArrangedSubview(signUpButton)
            addSubview($0)
        }
    }
    
    private func setupConstraints() {
        addPhotoButton.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.left.equalTo(10)
            $0.size.equalTo(120)
        }
        
        nameStackView.snp.makeConstraints {
            $0.centerY.equalTo(addPhotoButton)
            $0.left.equalTo(addPhotoButton.snp.right).offset(10)
            $0.right.equalTo(-10)
        }
        
        credentialsStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(nameStackView.snp.bottom).offset(10)
            $0.left.equalTo(addPhotoButton)
        }
    }
}

// MARK: - UITextFieldDelegate

extension RegistrationView: UITextFieldDelegate {
    private func configureTextFieldDelegate() {
        nicknameTextField.delegate = self
        fullnameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nicknameTextField: fullnameTextField.becomeFirstResponder()
        case fullnameTextField: emailTextField.becomeFirstResponder()
        case emailTextField: passwordTextField.becomeFirstResponder()
        case passwordTextField: passwordTextField.resignFirstResponder()
        default: nicknameTextField.becomeFirstResponder()
        }
        
        return true
    }
}
