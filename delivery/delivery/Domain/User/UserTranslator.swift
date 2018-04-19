//
//  AccountTranslator.swift
//  delivery
//
//  Created by Diego H. Vanni on 2018-03-12.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

class UserTranslator: TranslatorProtocol {
    func translate(_ entity: UserEntity) -> User {
        
        var addresses = [Address]()
        var payments = [Payment]()
        
        for address in entity.address {
            addresses.append(Address(receiver: address.receiver, address1: address.address1, address2: address.address2, city:address.city, province: address.province, postalCode: address.postalCode, country: address.postalCode, isDefault:address.isDefault))
        }
        
        for payment in entity.payment {
            payments.append(Payment(cardNumber: payment.cardNumber, holderName: payment.holderName, expiryDate: payment.expiryDate, isDefault: payment.isDefault))
        }
        
        return User(
            firstName: entity.firstName,
            lastName: entity.lastName,
            fullName: entity.fullName,
            dateOfBirth: entity.dateOfBirth,
            mobileNumber: entity.mobileNumber,
            email: entity.email,
            totalPoint: entity.totalPoint,
            address: addresses,
            payment: payments,
            coupon: entity.coupon!)
    }
}

