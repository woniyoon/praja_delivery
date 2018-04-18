//
//  AccountRepository.swift
//  delivery
//
//  Created by Diego H. Vanni on 2018-03-12.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol UserRepositoryProtocol{
    func fetchAccount(_ id: String) -> Single<UserEntity>
}

class UserRepository: UserRepositoryProtocol {
    
    private let dataStore: UserDataStoreProtocol
    
    init(dataStore: UserDataStoreProtocol) {
        self.dataStore = dataStore
    }
    
    func fetchAccount(_ id: String) -> Single<UserEntity>{
        return dataStore.fetchUser(id)
    }
}
