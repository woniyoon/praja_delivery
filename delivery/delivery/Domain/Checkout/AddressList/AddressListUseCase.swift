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
    func deleteAddress(index: Int) -> Void
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
    
    func deleteAddress(index: Int) {
        repository.deleteAddress(index: index)
    }
}

