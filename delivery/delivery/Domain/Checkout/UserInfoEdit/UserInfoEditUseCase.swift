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
}

class UserInfoEditUseCase: UserInfoEditUseCaseProtocol {
    
    internal let repository: UserRepositoryProtocol
    internal let translator: UserTranslator
    
    init(repository: UserRepositoryProtocol, translator: UserTranslator) {
        self.repository = repository
        self.translator = translator
    }
}

