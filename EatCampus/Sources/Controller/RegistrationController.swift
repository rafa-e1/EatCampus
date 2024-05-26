//
//  RegistrationController.swift
//  EatCampus
//
//  Created by RAFA on 5/26/24.
//

import UIKit

final class RegistrationController: UIViewController {
    
    // MARK: - Properties
    
    private let registrationView = RegistrationView()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        view = registrationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
    }
    
    // MARK: - Setup Navigation Bar Appearance
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.isHidden = false
    }
}
