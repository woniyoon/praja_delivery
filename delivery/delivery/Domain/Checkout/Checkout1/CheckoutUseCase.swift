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
    func fetchUser() -> Single<User>
    func updateUser()
}

class CheckoutUseCase: CheckoutUseCaseProtocol {
    
    internal let repository: UserRepositoryProtocol
    internal let translator: UserTranslator
    
    func fetchUser() -> Single<User> {
        return repository.fetchUser()    
                .map({ entity in
                    self.translator.translate(fromEntity: entity)
                })
    }
    
    func updateUser() {
        
    }
    
    init(repository: UserRepositoryProtocol, translator: UserTranslator) {
        self.repository = repository
        self.translator = translator
    }
}


