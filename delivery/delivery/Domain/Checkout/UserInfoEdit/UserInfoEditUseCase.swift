//
//  UserInfoEditUseCase.swift
//  delivery
//
//  Created by Jaewon Yoon on 2018-04-26.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

import Foundation
import RxSwift

protocol UserInfoEditUseCaseProtocol {
    func fetchUser() -> Single<User>
    func updateUser(user: User) -> Completable
}

class UserInfoEditUseCase: UserInfoEditUseCaseProtocol {

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
    
    func updateUser(user: User) -> Completable {
        let updatedUser = translator.translate(fromModel: user)
        return repository.updateUser(user: updatedUser)
    }
}

