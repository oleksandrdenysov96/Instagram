//
//  AuthManager.swift
//  Instagram
//
//  Created by Oleksandr Denysov on 14.12.2023.
//

import Foundation
import FirebaseAuth


final class AuthManager {
    
    static let shared = AuthManager()

    let auth = Auth.auth()

    private init() {}

    public var isSignedIn: Bool {
        return auth.currentUser != nil
    }

    public func signIn(
        email: String, 
        password: String,
        completion: @escaping (Result<User, Error>
        ) -> Void) {

    }

    public func signUp(
        email: String,
        username: String,
        password: String,
        profilePicture: Data?,
        completion: @escaping (Result<User, Error>
        ) -> Void) {

    }

    public func signOut(completion: @escaping (Bool) -> Void) {

    }
}
