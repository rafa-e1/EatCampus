//
//  AuthService.swift
//  EatCampus
//
//  Created by RAFA on 5/26/24.
//

import UIKit

import FirebaseAuth
import FirebaseFirestore

struct AuthCredentials {
    let profileImage: UIImage
    let nickname: String
    let email: String
    let password: String
}

struct AuthService {
    static func logUserIn(
        withEmail email: String,
        password: String,
        completion: @escaping(AuthDataResult?, Error?) -> Void
    ) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    static func registerUser(
        withCredential credentials: AuthCredentials,
        completion: @escaping(Error?) -> Void
    ) {
        ImageUploader.uploadImage(image: credentials.profileImage) { imageURL in
            Auth.auth().createUser(
                withEmail: credentials.email,
                password: credentials.password
            ) { result, error in
                if let error = error {
                    print("DEBUG: Failed to register user: \(error.localizedDescription)")
                    return
                }
                
                guard let uid = result?.user.uid else { return }
                
                let data: [String: Any] = [
                    "profileImageURL": imageURL,
                    "nickname": credentials.nickname,
                    "email": credentials.email,
                    "uid": uid
                ]
                
                COLLECTION_USERS.document(uid).setData(data, completion: completion)
            }
        }
    }
}
