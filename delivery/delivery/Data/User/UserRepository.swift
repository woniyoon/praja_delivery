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
    func addAddress(address: AddressEntity) -> Completable
    func updateAddress(address: AddressEntity, indexNo: Int) -> Completable
    func updateAddressList(address: [AddressEntity]) -> Completable
    func updateUser(user: UserEntity) -> Completable
}

class UserRepository: UserRepositoryProtocol {    
    
    private let dataStore: UserDataStoreProtocol
    private static var user: UserEntity? = nil

    init(dataStore: UserDataStoreProtocol) {
        self.dataStore = dataStore
    }
    
    func fetchUser() -> Single<UserEntity> {
        return dataStore.fetchUser().map{ user in
            UserRepository.user = user
            return user
        }
    }
    
    func fetchAddress(index: Int) -> Single<[AddressEntity]> {
        var arrWithOneElement: [AddressEntity] = []
        if let user = UserRepository.user {
            arrWithOneElement.append(user.address![index])
            return Single.just(arrWithOneElement)
        } else {
            return fetchUser()
                .map{ user in
                    UserRepository.user = user
                    arrWithOneElement.append(user.address![index])
                    return arrWithOneElement }
        }
    }
    
    func fetchAddressList() -> Single<[AddressEntity]> {
//        if let user = UserRepository.user {
//            print("************self.user is not empty********")
//            return Single.just(user.address)
//        } else {
//            print("************self.user is empty********")

            return fetchUser()
                .map{ user in
                    UserRepository.user = user
//                    print(UserRepository.user!)
                    return user.address!
            }
//        }
    }
    
    func addAddress(address: AddressEntity) -> Completable {
        let originalAddress = UserRepository.user?.address
        
        if let originalAddress = UserRepository.user?.address {
            let updatedAddress = originalAddress.map({ address in
                AddressEntity(receiver: address.receiver, address1: address.address1, address2: address.address2, city: address.city, province: address.province, postalCode: address.postalCode, country: address.country, isDefault: false, phoneNumber: address.phoneNumber)
            })
            UserRepository.user?.address = updatedAddress
            UserRepository.user?.address!.append(address)
        } else {
            UserRepository.user?.address = [address]
            
        }
        
        return dataStore.updateUser(user: UserRepository.user!)
    }
    
    func updateAddress(address: AddressEntity, indexNo: Int) -> Completable {
        let originalAddress = UserRepository.user?.address
        
        let updatedAddress = originalAddress?.map({ address in
            AddressEntity(receiver: address.receiver, address1: address.address1, address2: address.address2, city: address.city, province: address.province, postalCode: address.postalCode, country: address.country, isDefault: false, phoneNumber: address.phoneNumber)
        })
        
        UserRepository.user?.address = updatedAddress!
        UserRepository.user?.address!.remove(at: indexNo)
        UserRepository.user?.address!.insert(address, at: indexNo)        
        return dataStore.updateUser(user: UserRepository.user!)
    }
    
    func updateAddressList(address: [AddressEntity]) -> Completable {
        
        let updatedUser = UserEntity(firstName: (UserRepository.user?.firstName)!, lastName: (UserRepository.user?.lastName)!, mobileNumber: (UserRepository.user?.mobileNumber)!, dateOfBirth: UserRepository.user?.dateOfBirth, totalPoint: (UserRepository.user?.totalPoint)!, email: (UserRepository.user?.email)!, address: address, payment: (UserRepository.user?.payment)!, coupon: UserRepository.user?.coupon)
        
        return dataStore.updateUser(user: updatedUser!)
    }
    
    func updateUser(user: UserEntity) -> Completable {
        UserRepository.user = user
        return dataStore.updateUser(user: user)
    }
}




