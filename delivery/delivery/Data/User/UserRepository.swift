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
    func addAddress(address: AddressEntity) -> Completable
    func updateAddress(address: AddressEntity, indexNo: Int) -> Completable
    func deleteAddress(index: Int) -> Void
}

class UserRepository: UserRepositoryProtocol {    
    
    private let dataStore: UserDataStoreProtocol
    private static var user: UserEntity? = nil

    init(dataStore: UserDataStoreProtocol) {
        self.dataStore = dataStore
    }
    
    func fetchUser() -> Single<UserEntity> {
        return dataStore.fetchUser()
    }
    
    func fetchAddress(index: Int) -> Single<[AddressEntity]> {
        var arrWithOneElement: [AddressEntity] = []
        if let user = UserRepository.user {
            arrWithOneElement.append(user.address[index])
            return Single.just(arrWithOneElement)
        } else {
            return fetchUser()
                .map{ user in
                    UserRepository.user = user
                    arrWithOneElement.append(user.address[index])
                    return arrWithOneElement }
        }
    }
    
    func fetchAddressList() -> Single<[AddressEntity]> {
        if let user = UserRepository.user {
            print("************self.user is not empty********")
            return Single.just(user.address)
        } else {
            print("************self.user is empty********")

            return fetchUser()
                .map{ user in
                    UserRepository.user = user
                    print(UserRepository.user!)
                    return user.address
            }
        }
    }
    
    func addAddress(address: AddressEntity) -> Completable {
//        print("!@$#%^&*%$%#@$!#$%^&*^%$##@@#$%^&*")
//        print(address)
//        if let test = self.user {
//            print(test)
//        }
//        fetchUser().map { (user) in
//            UserRepository.user = user
//        }
        UserRepository.user?.address.append(address)
    
        print(UserRepository.user!)
        return dataStore.updateUser(user: UserRepository.user!)
    }
    
    func updateAddress(address: AddressEntity, indexNo: Int) -> Completable {
        UserRepository.user?.address.remove(at: indexNo)
        UserRepository.user?.address.insert(address, at: indexNo)
        
        return dataStore.updateUser(user: UserRepository.user!)
    }
    
    func deleteAddress(index: Int) {
    }
    
}




