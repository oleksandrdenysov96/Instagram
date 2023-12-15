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
}
