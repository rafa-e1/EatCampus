//
//  SettingController.swift
//  EatCampus
//
//  Created by RAFA on 5/26/24.
//

import UIKit

import FirebaseAuth
import SnapKit
import Then

final class SettingController: UIViewController {
    
    let darkModeSwitchToggleButton = UISwitch()
    
    let logoutButton = UIButton(type: .system).then {
        $0.setTitle("로그아웃", for: .normal)
    }
    
    let viewModel = SettingViewModel(darkMode: DarkMode())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        darkModeSwitchToggleButton.addTarget(self, action: #selector(handleDarkModeSwitchToggle), for: .valueChanged)
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        
        view.addSubview(darkModeSwitchToggleButton)
        view.addSubview(logoutButton)
        
        darkModeSwitchToggleButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        logoutButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(darkModeSwitchToggleButton.snp.bottom)
        }
    }
    
    @objc private func handleDarkModeSwitchToggle(_ sender: UISwitch) {
        viewModel.toggleDarkMode(animated: true)
        darkModeSwitchToggleButton.isOn = viewModel.isDarkModeEnabled
    }
    
    @objc private func logoutButtonTapped() {
        do {
            try Auth.auth().signOut()
            let controller = LoginController()
            controller.delegate = tabBarController as? MainTabBarController
            let navigationController = UINavigationController(rootViewController: controller)
            navigationController.modalPresentationStyle = .fullScreen
            present(navigationController, animated: true)
        } catch {
            print("DEBUG: Failed to sign out")
        }
    }
}
