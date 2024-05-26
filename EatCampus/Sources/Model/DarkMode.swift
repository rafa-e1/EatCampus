//
//  DarkMode.swift
//  EatCampus
//
//  Created by RAFA on 5/27/24.
//

import Foundation

struct DarkMode {
    var isDarkModeEnabled: Bool {
        get { UserDefaults.standard.bool(forKey: "DarkModeEnabled") }
        set { UserDefaults.standard.set(newValue, forKey: "DarkModeEnabled") }
    }
}
