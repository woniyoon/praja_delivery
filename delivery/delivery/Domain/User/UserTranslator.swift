//
//  UserTranslator.swift
//  delivery
//
//  Created by Sara N on 2018-03-12.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

class UserTranslator: TranslatorProtocol {
    func translate(_ entity: UserEntity) -> User {
        return User(firstName: entity.firstName, lastName: entity.lastName, mobileNumber: entity.mobileNumber, dateOfBirth: entity.dateOfBirth, hasAccount: entity.hasAccount, email: entity.email, totalPoint: entity.totalPoint, address: entity.address, payment: entity.payment, coupon: entity.coupon)
    }
}
