//
//  UserRepository.swift
//  delivery
//
//  Created by Sara N on 2018-03-12.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

protocol UserRepositoryProtocol {
    func fetchUser(_ id: String) -> UserEntity
}

class UserRepository: UserRepositoryProtocol {
    
    private let dataStore: UserDataStoreProtocol
    
    init(dataStore: UserDataStoreProtocol) {
        self.dataStore = dataStore
    }
    
    func fetchUser(_ id: String) -> UserEntity {
        return dataStore.fetchUser(id)
    }
}
