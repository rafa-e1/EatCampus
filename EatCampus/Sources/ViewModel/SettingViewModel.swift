//
//  SettingViewModel.swift
//  EatCampus
//
//  Created by RAFA on 5/27/24.
//

import UIKit

final class SettingViewModel {
    
    // MARK: - Properties
    
    private var darkMode: DarkMode
    
    var isDarkModeEnabled: Bool {
        get { darkMode.isDarkModeEnabled }
        set { darkMode.isDarkModeEnabled = newValue }
    }
    
    // MARK: - Initialization
    
    init(darkMode: DarkMode) {
        self.darkMode = darkMode
    }
    
    // MARK: - Actions
    
    func toggleDarkMode(animated: Bool) {
        isDarkModeEnabled.toggle()
        updateInterfaceStyle(animated: true)
    }
    
    // MARK: - Helpers
    
    private func updateInterfaceStyle(animated: Bool) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return
        }
        
        for window in windowScene.windows {
            if animated {
                UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve) {
                    window.overrideUserInterfaceStyle = self.isDarkModeEnabled ? .dark : .light
                }
            } else {
                window.overrideUserInterfaceStyle = self.isDarkModeEnabled ? .dark : .light
            }
        }
    }
}
