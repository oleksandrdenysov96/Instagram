//
//  AuthManager.swift
//  Instagram
//
//  Created by Oleksandr Denysov on 14.12.2023.
//

import Foundation
import FirebaseAuth


final class AuthManager {

    enum AuthError: Error {
        case newUserCreation
        case signInFailed
    }

    static let shared = AuthManager()

    let auth = Auth.auth()

    private init() {}

    public var isSignedIn: Bool {
        return auth.currentUser != nil
    }

    public var getCurrentUserEmail: String {
        guard let email = UserDefaults.standard.string(forKey: "email") else {
            IGLogger.shared.debugInfo("no such email in user defaults")
            return ""
        }
        return email
    }

    public var getCurrentUserName: String {
        guard let username = UserDefaults.standard.string(forKey: "username") else {
            IGLogger.shared.debugInfo("no such username in user defaults")
            return ""
        }
        return username
    }

    public func signIn(
        email: String, 
        password: String,
        completion: @escaping (Result<User, Error>
        ) -> Void) {

        DatabaseManager.shared.findUser(with: email) { [weak self] user in
            guard let user = user else {
                IGLogger.shared.debugInfo("auth manager: user is nil")
                completion(.failure(AuthError.signInFailed))
                return
            }

            self?.auth.signIn(withEmail: email, password: password) { result, error in
                guard result != nil, error == nil else {
                    IGLogger.shared.debugInfo("auth manager: sign in error")
                    completion(.failure(AuthError.signInFailed))
                    return
                }

                UserDefaults.standard.set(user.username, forKey: "username")
                UserDefaults.standard.set(user.email, forKey: "email")
                completion(.success(user))
            }
        }
    }

    public func signUp(
        email: String,
        username: String,
        password: String,
        profilePicture: Data?,
        completion: @escaping (Result<User, Error>) -> Void) {

            let newUser = User(username: username, email: email)

            auth.createUser(withEmail: email, password: password) { result, error in
                guard result != nil, error == nil else {
                    completion(.failure(AuthError.newUserCreation))
                    IGLogger.shared.debugInfo("failed to create a user with email \(email)")
                    return
                }

                DatabaseManager.shared.createUser(with: newUser) { success in
                    if success {
                        StorageManager.shared.uploadProfilePicture(username: username, data: profilePicture) { isUploaded in
                            if isUploaded {
                                completion(.success(newUser))
                            }
                            else {
                                IGLogger.shared.debugInfo("failed to upload user picture on signup")
                                completion(.failure(AuthError.newUserCreation))
                            }
                        }
                    }
                    else {
                        IGLogger.shared.debugInfo("failed to store new user in DB")
                        IGLogger.shared.debugInfo("user email \(email)")
                        completion(.failure(AuthError.newUserCreation))
                    }
                }
            }
    }

    public func signOut(completion: @escaping (Bool) -> Void) {
        do {
            try auth.signOut()
            completion(true)
        }
        catch {
            IGLogger.shared.debugInfo("failed to sign out")
            IGLogger.shared.debugInfo("error: \(error)")
            completion(false)
        }
    }
}
