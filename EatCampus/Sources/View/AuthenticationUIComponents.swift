//
//  AuthenticationUIComponents.swift
//  EatCampus
//
//  Created by RAFA on 5/26/24.
//

import UIKit

import SnapKit

// MARK: - AuthenticationTextField

final class AuthenticationTextField: UITextField {
    
    // MARK: Lifecycle
    
    init(placeholder: String, isSecure: Bool) {
        super.init(frame: .zero)
        
        configureTextField(with: placeholder, isSecure: isSecure)
        setupLeftView()
        if isSecure {
            setupRightView()
        }
        applyStyles()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSecureTextEntry: Bool {
        didSet {
            if isFirstResponder {
                _ = becomeFirstResponder()
            }
        }
    }
    
    @discardableResult
    override func becomeFirstResponder() -> Bool {
        let success = super.becomeFirstResponder()
        if isSecureTextEntry, let text = self.text {
            self.text?.removeAll()
            insertText(text)
        }
        
        return success
    }
    
    // MARK: Configuration
    
    private func configureTextField(with placeholder: String, isSecure: Bool) {
        spellCheckingType = .no
        autocorrectionType = .no
        autocapitalizationType = .none
        self.isSecureTextEntry = isSecure
        if isSecure {
            textContentType = .newPassword
        }
        attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [.foregroundColor: UIColor.systemGray]
        )
    }
    
    private func setupLeftView() {
        let spacer = UIView(frame: .init(x: 0, y: 0, width: 12, height: 50))
        leftView = spacer
        leftViewMode = .always
    }
    
    private func setupRightView() {
        let eyeButton = UIButton(type: .system)
        eyeButton.tintColor = .label
        
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "eye.slash")
        config.imagePadding = 10
        
        eyeButton.configuration = config
        eyeButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        
        rightView = eyeButton
        rightViewMode = .always
    }
    
    private func applyStyles() {
        textColor = .label
        tintColor = .label
        borderStyle = .none
        layer.cornerRadius = 10
        keyboardAppearance = .dark
        keyboardType = .emailAddress
        backgroundColor = .textFieldBackground
        snp.makeConstraints { $0.height.equalTo(50) }
    }
    
    @objc private func togglePasswordVisibility() {
        isSecureTextEntry.toggle()
        if let eyeButton = rightView as? UIButton {
            let icon = isSecureTextEntry ? "eye.slash" : "eye"
            eyeButton.setImage(UIImage(systemName: icon), for: .normal)
        }
    }
}

// MARK: - UIButton + Extension

extension UIButton {
    func authenticationButton(title: String) {
        isEnabled = false
        layer.cornerRadius = 10
        setTitle(title, for: .normal)
        setTitleColor(.systemBackground.withAlphaComponent(0.67), for: .normal)
        backgroundColor = .buttonBackground.withAlphaComponent(0.8)
        snp.makeConstraints { $0.height.equalTo(50) }
    }
    
    func attributedTitle(
        firstPart: String,
        _ firstPartColor: UIColor,
        secondPart: String,
        _ secondPartColor: UIColor
    ) {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 16, weight: .regular),
            .foregroundColor: firstPartColor
        ]
        
        let attributedTitle = NSMutableAttributedString(
            string: "\(firstPart)",
            attributes: attributes
        )
        
        let boldString: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 16),
            .foregroundColor: secondPartColor
        ]
        
        attributedTitle.append(NSAttributedString(string: secondPart, attributes: boldString))
        setAttributedTitle(attributedTitle, for: .normal)
    }
}
