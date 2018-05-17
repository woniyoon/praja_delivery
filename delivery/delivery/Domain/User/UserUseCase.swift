//
//  UserUseCaseProtocol.swift
//  delivery
//
//  Created by Sara N on 2018-03-12.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import RxSwift


protocol UserUseCaseProtocol {
    func signUp(email: String, password: String, confirm: String) -> Completable
    func fetchUser() -> Single<User>
    func updateUser(user: User) -> Completable
    func fetchAddressList() -> Single<[Address]>
    func updateAddressList(addressList: [Address]) -> Completable
    func fetchAddress(index: Int) -> Single<[Address]>
    func addAddress(address: Address) -> Completable
    func updateAddress(address: Address, indexNo: Int) -> Completable
}

class UserUseCase: UserUseCaseProtocol {
    
    internal let repository: UserRepositoryProtocol
    internal let translator: UserTranslator
    
    init(repository: UserRepositoryProtocol, translator: UserTranslator) {
        self.repository = repository
        self.translator = translator
    }
    
    func signUp(email: String, password: String, confirm: String) -> Completable {
        if email.isEmpty, password.isEmpty, confirm.isEmpty {
            return Completable.error(NomnomError.alert(message: "Please fill out"))
        }
        if password != confirm {
            return Completable.error(NomnomError.alert(message: "Confirm password is differnt from Password"))
        }
        return repository.signUp(email: email, password: password)
    }
    
    func fetchUser() -> Single<User> {
        return repository.fetchUser()
            .map({ entity in
                self.translator.translate(fromEntity: entity)
            })
    }
    
    func updateUser(user: User) -> Completable {
        let updatedUser = translator.translate(fromModel: user)
        return repository.updateUser(user: updatedUser)
    }
    
    func fetchAddressList() -> Single<[Address]> {
        return repository.fetchAddressList()
            .map({ entity in
                self.translator.translateAddress(from: entity)
            })
    }
    
    func updateAddressList(addressList: [Address]) -> Completable {
        let addressList = addressList.map { self.translator.translateAddress(from: $0)}
        return repository.updateAddressList(address: addressList)
    }
    
    func fetchAddress(index: Int) -> Single<[Address]> {
        return repository.fetchAddress(index: index)
            .map({ entity in
                self.translator.translateAddress(from: entity)
            })
    }
    
    func addAddress(address: Address) -> Completable {
        let addressEntity = self.translator.translateAddress(from: address)
        return repository.addAddress(address: addressEntity)
    }
    
    func updateAddress(address: Address, indexNo: Int) -> Completable {
        let addressEntity = self.translator.translateAddress(from: address)
        return repository.updateAddress(address: addressEntity, indexNo: indexNo)
    }
}

