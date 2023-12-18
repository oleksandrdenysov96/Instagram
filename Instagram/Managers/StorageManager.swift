//
//  StorageManager.swift
//  Instagram
//
//  Created by Oleksandr Denysov on 14.12.2023.
//

import Foundation
import FirebaseStorage

final class StorageManager {
    static let shared = StorageManager()

    private let storage = Storage.storage().reference()

    private init() {}

    public func uploadProfilePicture(username: String, data: Data?, 
                                     completion: @escaping (Bool) -> Void) {

        guard let data = data else {
            completion(false)
            return
        }
        storage.child("\(username)/profile_picture.png").putData(data) { _, error in
            completion(error == nil)
        }

    }
}
