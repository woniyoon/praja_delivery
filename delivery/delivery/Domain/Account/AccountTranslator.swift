//
//  AccountTranslator.swift
//  delivery
//
//  Created by Diego H. Vanni on 2018-03-12.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation


class AccountTranslator: TranslatorProtocol {
    func translate(_ entity: AccountEntity) -> Account {
        return Account(
            firstName: entity.firstName,
            lastName: entity.lastName,
            fullName: entity.fullName,
            dateOfBirth: entity.dateOfBirth,
            mobileNumber: entity.mobileNumber,
            email: entity.email,
            totalPoint: entity.totalPoint,
            address: entity.address,
            payment: entity.payment,
            token: entity.token)
    }
}

