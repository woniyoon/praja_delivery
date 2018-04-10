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
}

class AddressEditUseCase: AddressEditUseCaseProtocol {
    internal let repository: AccountRepositoryProtocol
    internal let translator: CheckoutTranslator
    
    
    init(repository: AccountRepositoryProtocol, translator: CheckoutTranslator) {
        self.repository = repository
        self.translator = translator
    }
}

