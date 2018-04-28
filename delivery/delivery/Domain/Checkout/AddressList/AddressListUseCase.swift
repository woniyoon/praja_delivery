//
//  AddressListUseCase.swift
//  delivery
//
//  Created by Jaewon Yoon on 2018-04-20.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

import RxSwift

protocol AddressListUseCaseProtocol {
    func fetchAddressList() -> Single<[Address]>
    func updateAddressList(addressList: [Address]) -> Completable
}

class AddressListUseCase: AddressListUseCaseProtocol {
    
    internal let repository: UserRepositoryProtocol
    internal let translator: UserTranslator
    
    init(repository: UserRepositoryProtocol, translator: UserTranslator) {
        self.repository = repository
        self.translator = translator
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
}

