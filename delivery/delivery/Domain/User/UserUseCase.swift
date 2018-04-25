//
//  UserUseCase.swift
//  delivery
//
//  Created by Diego H. Vanni on 2018-03-12.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol UserUseCaseProtocol {
    func fetchUser() -> Single<User>
}

class UserUseCase: UserUseCaseProtocol {
    
    internal let repository: UserRepositoryProtocol
    internal let translator: UserTranslator
    
    init(repository: UserRepositoryProtocol, translator: UserTranslator) {
        self.repository = repository
        self.translator = translator
    }
    
    func fetchUser() -> Single<User> {
        return repository.fetchUser()
            .map({ entity in
                self.translator.translate(fromEntity: entity)
            })
    }
}
