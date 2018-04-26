//
//  AddressEditUseCase.swift
//  delivery
//
//  Created by Jaewon Yoon on 2018-04-06.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import RxSwift

protocol AddressEditUseCaseProtocol {
    func fetchAddress(index: Int) -> Single<[Address]>
    func addAddress(address: Address) -> Completable
    func updateAddress(address: Address, indexNo: Int) -> Completable
}

class AddressEditUseCase: AddressEditUseCaseProtocol {

    internal let repository: UserRepositoryProtocol
    internal let translator: UserTranslator
    
    init(repository: UserRepositoryProtocol, translator: UserTranslator) {
        self.repository = repository
        self.translator = translator
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

