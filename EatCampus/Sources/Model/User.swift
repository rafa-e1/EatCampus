//
//  User.swift
//  EatCampus
//
//  Created by RAFA on 5/26/24.
//

import Foundation

struct User {
    let profileImageURL: String
    let nickname: String
    let fullname: String
    let email: String
    let uid: String
    
    init(dictionary: [String: Any]) {
        profileImageURL = dictionary["profileImageURL"] as? String ?? ""
        nickname = dictionary["nickname"] as? String ?? ""
        fullname = dictionary["fullname"] as? String ?? ""
        email = dictionary["email"] as? String ?? ""
        uid = dictionary["uid"] as? String ?? ""
    }
}
