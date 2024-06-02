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
    
    private var isKeyboardAlreadyShown = false
    
    let addPhotoButton = UIButton(type: .system)
    private var textFields: [UITextField] = []
    let nicknameTextField = AuthenticationTextField(placeholder: "닉네임", isSecure: false)
    let emailTextField = AuthenticationTextField(placeholder: "이메일", isSecure: false)
    let passwordTextField = AuthenticationTextField(placeholder: "비밀번호", isSecure: true)
    let confirmPasswordTextField = AuthenticationTextField(placeholder: "비밀번호 확인", isSecure: true)
    let signUpButton = UIButton(type: .system)
    private let credentialsStackView = UIStackView()
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupConstraints()
        configureTextFieldDelegate()
        registerKeyboardNotifications()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        endEditing(true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        backgroundColor = .background
        
        addPhotoButton.do {
            $0.setImage(
                UIImage(systemName: "plus")?
                    .withTintColor(.systemBlue, renderingMode: .alwaysOriginal)
                    .withConfiguration(
                        UIImage.SymbolConfiguration(pointSize: 30, weight: .light)
                    ),
                for: .normal
            )
            $0.layer.cornerRadius = 180 / 2
            $0.layer.masksToBounds = true
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.buttonBackground.cgColor
            
            addSubview($0)
        }
        
        signUpButton.do {
            $0.authenticationButton(title: "회원가입")
        }
        
        credentialsStackView.do {
            $0.axis = .vertical
            $0.spacing = 10
            $0.addArrangedSubview(nicknameTextField)
            $0.addArrangedSubview(emailTextField)
            $0.addArrangedSubview(passwordTextField)
            $0.addArrangedSubview(confirmPasswordTextField)
            $0.addArrangedSubview(signUpButton)
            addSubview($0)
        }
        
        activityIndicator.do {
            $0.color = .systemYellow
            $0.hidesWhenStopped = true
            addSubview($0)
        }
    }
    
    private func setupConstraints() {
        addPhotoButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.size.equalTo(180)
        }
        
        credentialsStackView.snp.makeConstraints {
            $0.centerX.equalTo(addPhotoButton)
            $0.top.lessThanOrEqualTo(addPhotoButton.snp.bottom).offset(20)
            $0.left.equalTo(10)
            $0.bottom.equalTo(keyboardLayoutGuide.snp.top).offset(-20)
        }
        
        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    // MARK: - Actions
    
    func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    @objc func keyboardWillShow(_ notification: Notification) {
        if !isKeyboardAlreadyShown {
            UIView.animate(withDuration: 0.3) {
                self.backgroundColor = .black.withAlphaComponent(0.8)
                self.addPhotoButton.alpha = 0.2
                self.bringSubviewToFront(self.credentialsStackView)
            }
            isKeyboardAlreadyShown = true
        }
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.backgroundColor = .background
            self.addPhotoButton.alpha = 1
        }
        isKeyboardAlreadyShown = false
    }
}

// MARK: - UITextFieldDelegate

extension RegistrationView: UITextFieldDelegate {
    private func configureTextFieldDelegate() {
        textFields = [
            nicknameTextField,
            emailTextField,
            passwordTextField,
            confirmPasswordTextField
        ]
        
        textFields.forEach { $0.delegate = self }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case nicknameTextField: emailTextField.becomeFirstResponder()
        case emailTextField: passwordTextField.becomeFirstResponder()
        case passwordTextField: confirmPasswordTextField.becomeFirstResponder()
        case confirmPasswordTextField: confirmPasswordTextField.resignFirstResponder()
        default: nicknameTextField.becomeFirstResponder()
        }
        
        return true
    }
}
