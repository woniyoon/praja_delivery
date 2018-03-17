//
//  AccountViewModel.swift
//  delivery
//
//  Created by Diego H. Vanni on 2018-03-13.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class AccountViewModel {
    
    var accountId = BehaviorRelay(value: 0)
    var email = BehaviorRelay(value: "")
    var password = BehaviorRelay(value: "")
    var token = BehaviorRelay(value: "")
    
    private let useCase: AccountUseCaseProtocol
    
    init(useCase: AccountUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func fetchAccount(_ id: Int) {
        let model = useCase.fetchAccount(id)
        accountId.accept(model.accountId)
        email.accept(model.email)
        password.accept(model.password)
        token.accept(model.token)
    }
}

