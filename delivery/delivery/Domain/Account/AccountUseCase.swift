//
//  AccountUseCase.swift
//  delivery
//
//  Created by Diego H. Vanni on 2018-03-12.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol AccountUseCaseProtocol {
    func fetchAccount(_ id: String) -> Single<Account>
}

class AccountUseCase: AccountUseCaseProtocol {
    
    internal let repository: AccountRepositoryProtocol
    internal let translator: AccountTranslator
    
    init(repository: AccountRepositoryProtocol, translator: AccountTranslator) {
        self.repository = repository
        self.translator = translator
    }
    
    var counter: Int = 0
    func fetchAccount(_ id: String) -> Single<Account> {
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
