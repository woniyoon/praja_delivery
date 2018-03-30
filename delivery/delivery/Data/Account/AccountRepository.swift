//
//  AccountRepository.swift
//  delivery
//
//  Created by Diego H. Vanni on 2018-03-12.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol AccountRepositoryProtocol{
    func fetchAccount(_ id: String) -> Single<AccountEntity>
}

class AccountRepository: AccountRepositoryProtocol {
    
    private let dataStore: AccountDataStoreProtocol
    
    init(dataStore: AccountDataStoreProtocol) {
        self.dataStore = dataStore
    }
    
    func fetchAccount(_ id: String) -> Single<AccountEntity>{
        return dataStore.fetchAccount(id)
    }
}
