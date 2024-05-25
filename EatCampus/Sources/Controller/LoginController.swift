//
//  LoginController.swift
//  EatCampus
//
//  Created by RAFA on 5/25/24.
//

import UIKit

final class LoginController: UIViewController {
    
    private let loginView = LoginView()
    
    override func loadView() {
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
