//
//  ProfileHeaderViewModel.swift
//  EatCampus
//
//  Created by RAFA on 5/26/24.
//

import Foundation

struct ProfileHeaderViewModel {
    let user: User
    
    var profileImageURL: URL? {
        return URL(string: user.profileImageURL)
    }
    
    var nickname: String {
        return user.nickname
    }
    
    init(user: User) {
        self.user = user
    }
}
