//
//  CheckoutTranslator.swift
//  delivery
//
//  Created by Jaewon Yoon on 2018-04-04.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

class CheckoutTranslator: TranslatorProtocol {
    func translate(_ entity: UserEntity) -> User {
        return User(firstName: entity.firstName, lastName: entity.lastName, mobileNumber: entity.mobileNumber, dateOfBirth: entity.dateOfBirth, email: entity.email, totalPoint: entity.totalPoint, address: entity.address, payment: entity.payment, coupon: entity.coupon)
    }
}
