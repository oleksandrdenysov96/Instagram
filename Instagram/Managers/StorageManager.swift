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

    let storage = Storage.storage()

    private init() {}
}
