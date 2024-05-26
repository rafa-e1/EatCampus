//
//  MainTabBarController.swift
//  EatCampus
//
//  Created by RAFA on 5/26/24.
//

import UIKit

import FirebaseAuth

final class MainTabBarController: UITabBarController {
    
    // MARK: - Properties
    
    private var user: User? {
        didSet {
            guard let user = user else { return }
            configureViewControllers(withUser: user)
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkIfUserIsLoggedIn()
        fetchUser()
        configureTabBar()
    }
    
    // MARK: - API
    
    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let controller = LoginController()
                controller.delegate = self
                let navigationController = UINavigationController(rootViewController: controller)
                navigationController.modalPresentationStyle = .fullScreen
                self.present(navigationController, animated: true)
            }
        }
    }
    
    func fetchUser() {
        UserService.fetchUser { user in
            self.user = user
        }
    }
    
    // MARK: - Helpers
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        Vibration.soft.vibrate()
    }
    
    func configureViewControllers(withUser user: User) {
        viewControllers = [
            Tab.home(self),
            Tab.now(self),
            Tab.vote(self),
            Tab.profile(self, withUser: user),
            Tab.setting(self)
        ]
    }
    
    // MARK: - Configuration
    
    private func configureTabBar() {
        
    }
}

// MARK: - AuthenticationDelegate

extension MainTabBarController: AuthenticationDelegate {
    func authenticationDidComplete() {
        fetchUser()
        dismiss(animated: true)
    }
}
