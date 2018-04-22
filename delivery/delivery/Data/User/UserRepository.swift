//
//  UserRepository.swift
//  delivery
//
//  Created by Sara N on 2018-03-12.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import RxSwift

protocol UserRepositoryProtocol {
    func fetchUser() -> Single<UserEntity>
    func fetchAddress(index: Int) -> Single<[AddressEntity]>
    func fetchAddressList() -> Single<[AddressEntity]>
    func updateAddress(address: AddressEntity) -> Void
    func deleteAddress(index: Int) -> Void
}

class UserRepository: UserRepositoryProtocol {    
    
    private let dataStore: UserDataStoreProtocol
    private var user: UserEntity? = nil

    init(dataStore: UserDataStoreProtocol) {
        self.dataStore = dataStore
    }
    
    func fetchUser() -> Single<UserEntity> {
        return dataStore.fetchUser()
    }
    
    func fetchAddress(index: Int) -> Single<[AddressEntity]> {
        if let user = self.user {
            return Single.just(user.address)
        } else {
            return fetchUser()
                .map{ user in user.address}
        }
    }
    
    func fetchAddressList() -> Single<[AddressEntity]> {
        if let user = self.user {
            return Single.just(user.address)
        } else {
            return fetchUser()
                .map{ user in user.address}
        }
    }
    
    func updateAddress(address: AddressEntity) {
    }
    
    func deleteAddress(index: Int) {
        
    }
}




