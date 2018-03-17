//
//  UserUseCaseProtocol.swift
//  delivery
//
//  Created by Sara N on 2018-03-12.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation


protocol UserUseCaseProtocol {
    func fetchUser(_ id: String) -> UserModel
}

class UserUseCase: UserUseCaseProtocol {
    
    internal let repository: UserRepositoryProtocol
    internal let translator: UserTranslator
    
    init(repository: UserRepositoryProtocol, translator: UserTranslator) {
        self.repository = repository
        self.translator = translator
    }
    
    func fetchUser(_ id: String) -> UserModel {
        let entity = repository.fetchUser(id)
        return translator.translate(entity)
    }
}

