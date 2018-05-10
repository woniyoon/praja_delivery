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
    func fetchAccount(_ id: String) -> Single<User>
}

class UserUseCase: UserUseCaseProtocol {
    
    internal let repository: UserRepositoryProtocol
    internal let translator: UserTranslator
    
    init(repository: UserRepositoryProtocol, translator: UserTranslator) {
        self.repository = repository
        self.translator = translator
    }
    
    var counter: Int = 0
    func fetchAccount(_ id: String) -> Single<User> {
        if counter > 0 {
            return Single.error(NomnomError.alert(message: "Don't press twice...!!"))
        }
        counter = counter + 1
        return repository.fetchAccount(_: id)
            .map({ entity in
                self.translator.translate(entity)
            })
    }
}
