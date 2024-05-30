//
//  AuthenticationViewModel.swift
//  EatCampus
//
//  Created by RAFA on 5/26/24.
//

import UIKit

protocol FormViewModel {
    func updateForm()
}

protocol AuthenticationViewModel {
    var isFormValid: Bool { get }
    var buttonBackgroundColor: UIColor { get }
    var buttonTitleColor: UIColor { get }
}

struct LoginViewModel: AuthenticationViewModel {
    var email: String?
    var password: String?
    
    var isFormValid: Bool {
        return isEmailValid(email) && password?.isEmpty == false
    }
    
    var buttonBackgroundColor: UIColor {
        return isFormValid ? .buttonBackground : .buttonBackground.withAlphaComponent(0.8)
    }
    
    var buttonTitleColor: UIColor {
        return isFormValid ? .systemBackground : .systemBackground.withAlphaComponent(0.67)
    }
    
    private func isEmailValid(_ email: String?) -> Bool {
        guard let email = email else { return false }
        let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailPattern)
        return emailPredicate.evaluate(with: email)
    }
}

struct RegistrationViewModel: AuthenticationViewModel {
    var nickname: String?
    var email: String?
    var password: String?
    var confirmPassword: String?
    
    var isFormValid: Bool {
        return isNicknameValid(nickname) && isEmailValid(email) &&
               isPasswordValid(password) && isConfirmPasswordValid(confirmPassword)
    }
    
    var buttonBackgroundColor: UIColor {
        return isFormValid ? .buttonBackground : .buttonBackground.withAlphaComponent(0.8)
    }
    
    var buttonTitleColor: UIColor {
        return isFormValid ? .systemBackground : .systemBackground.withAlphaComponent(0.67)
    }
    
    private func isNicknameValid(_ nickname: String?) -> Bool {
        guard let nickname = nickname, !nickname.isEmpty else { return false }
        return true
    }
    
    private func isEmailValid(_ email: String?) -> Bool {
        guard let email = email else { return false }
        let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailPattern)
        return emailPredicate.evaluate(with: email)
    }
    
    private func isPasswordValid(_ password: String?) -> Bool {
        guard let password = password, !password.isEmpty else { return false }
        return true
    }
    
    private func isConfirmPasswordValid( _ confirmPassword: String?) -> Bool {
        guard let confirmPassword = confirmPassword,
                  confirmPassword == password,
                  !confirmPassword.isEmpty
        else {
            return false
        }
        
        return true
    }
}
