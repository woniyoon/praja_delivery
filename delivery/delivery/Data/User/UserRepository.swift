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
        var arrWithOneElement: [AddressEntity] = []
        if let user = self.user {
            arrWithOneElement.append(user.address[index])
            return Single.just(arrWithOneElement)
        } else {
            return fetchUser()
                .map{ user in
                    arrWithOneElement.append(user.address[index])
                    return arrWithOneElement }
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
        dataStore.updateAddress(address: address)
    }
    
    func deleteAddress(index: Int) {
    }
    
}




