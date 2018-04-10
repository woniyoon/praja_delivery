//
//  CheckoutUseCase.swift
//  delivery
//
//  Created by Jaewon Yoon on 2018-04-04.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import RxSwift

protocol CheckoutUseCaseProtocol {
    func fetchAccount(_ id: String)
}

class CheckoutUseCase: CheckoutUseCaseProtocol {
    internal let repository: AccountRepositoryProtocol
    internal let translator: CheckoutTranslator
    
    func fetchAccount(_ id: String) {
        print("test")
    }
    
    init(repository: AccountRepositoryProtocol, translator: CheckoutTranslator) {
        self.repository = repository
        self.translator = translator
    }
}


