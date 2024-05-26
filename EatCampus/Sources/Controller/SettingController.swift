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
    
    let logoutButton = UIButton(type: .system).then {
        $0.setTitle("로그아웃", for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        view.addSubview(logoutButton)
        logoutButton.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
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
