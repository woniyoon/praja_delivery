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
    func updateAddress(address: Address) -> Void
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
    
    func updateAddress(address: Address) {
        let addressEntity = self.translator.translateAddress(from: address)
        repository.updateAddress(address: addressEntity)
    }
    
}

