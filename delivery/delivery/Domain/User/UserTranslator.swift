//
//  UserTranslator.swift
//  delivery
//
//  Created by Sara N on 2018-03-12.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

class UserTranslator: TranslatorProtocol {
    func translate(_ entity: UserEntity) -> UserModel {
        return UserModel(
            firstName: entity.firstName
            )
    }
}
