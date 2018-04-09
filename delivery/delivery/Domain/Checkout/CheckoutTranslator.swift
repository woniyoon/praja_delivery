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
        return User(firstName: entity.firstName,
                    lastName: entity.lastName,
                    mobileNumber: entity.mobileNumber,
                    dateOfBirth: entity.dateOfBirth,
                    email: entity.email,
                    totalPoint: entity.totalPoint,
                    address: translateAddress(from: entity.address),
                    payment: translatePayment(from: entity.payment),
                    coupon: entity.coupon)
    }
    
    func translateAddress(from address: [AddressEntity]) -> [Address] {
        var arr: [Address] = []
        
        address.forEach { (element) in
            arr.append(Address(receiver: element.receiver, address1: element.address1, address2: element.address2, city: element.city, province: element.province, postalCode: element.postalCode, country: element.country))
        }
        return arr
    }
    
    func translatePayment(from payment: [PaymentEntity]) -> [Payment] {
        var arr: [Payment] = []
        
        payment.forEach { (element) in
            arr.append(Payment(cardNumber: element.cardNumber, holderName: element.holderName, expiryDate: element.expiryDate))
        }
        return arr
    }
}
