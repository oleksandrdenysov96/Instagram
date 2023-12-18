//
//  DatabaseManager.swift
//  Instagram
//
//  Created by Oleksandr Denysov on 14.12.2023.
//

import Foundation
import FirebaseFirestore

final class DatabaseManager {
    static let shared = DatabaseManager()

    let database = Firestore.firestore()

    private init() {}

    public func createUser(with model: User, completion: @escaping (Bool) -> Void) {
        let reference = database.document("users/\(model.username)")

        guard let data = model.asDictionary() else {
            completion(false)
            return
        }
        reference.setData(data) { error in
            completion(error == nil)
        }
    }

    public func findUser(with email: String, completion: @escaping (User?) -> Void) {
        let reference = database.collection("users")
        reference.getDocuments { snapshot, error in
            guard let users = snapshot?.documents.compactMap({
                    User(with: $0.data())
                }),
                  error == nil
            else {
                IGLogger.shared.debugInfo("db error: unable to find such user - \(email)")
                completion(nil)
                return
            }
            let expectedUser = users.first { $0.email == email }
            completion(expectedUser)

        }
    }
}
