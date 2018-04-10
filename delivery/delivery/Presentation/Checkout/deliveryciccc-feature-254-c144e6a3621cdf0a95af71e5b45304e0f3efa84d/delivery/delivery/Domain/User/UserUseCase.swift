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
    func fetchUser(_ id: String) -> Single<User>
}

class UserUseCase: UserUseCaseProtocol {
    
    internal let repository: UserRepositoryProtocol
    internal let translator: UserTranslator
    
    init(repository: UserRepositoryProtocol, translator: UserTranslator) {
        self.repository = repository
        self.translator = translator
    }
    
    func fetchUser(_ id: String) -> Single<User> {
        return repository.fetchUser(id)
            .map({ entity in
                self.translator.translate(entity)
            })
    }
}

