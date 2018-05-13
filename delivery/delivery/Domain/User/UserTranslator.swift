//
//  UserTranslator.swift
//  delivery
//
//  Created by Sara N on 2018-03-12.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

class UserTranslator {
    func translate(fromEntity entity: UserEntity) -> User {
            return User(firstName: entity.firstName,
                        lastName: entity.lastName,
                        mobileNumber: entity.mobileNumber,
                        dateOfBirth: entity.dateOfBirth,
                        email: entity.email,
                        totalPoint: entity.totalPoint,
                        address: entity.address != nil ? translateAddress(from: entity.address!) : nil,
                        payment: entity.payment != nil ? translatePayment(from: entity.payment!) : nil,
                        coupon: entity.coupon!)
    }

    func translate(fromModel model: User) -> UserEntity {
        return UserEntity(firstName: model.firstName,
                          lastName: model.lastName,
                          mobileNumber: model.mobileNumber,
                          dateOfBirth: model.dateOfBirth != nil ? model.dateOfBirth! : nil,
                          totalPoint: model.totalPoint,
                          email: model.email,
                          address: model.address != nil ? model.address!.map({translateAddress(from: $0)}) : nil,
                          payment: model.payment != nil ? model.payment!.map({translatePaymentModel(from: $0)}) : nil ,
                          coupon: model.coupon)
    }
    
    func translateAddress(from address: [AddressEntity]) -> [Address] {
        var arr: [Address] = []
        
        address.forEach { (element) in
            arr.append(Address(receiver: element.receiver, address1: element.address1, address2: element.address2, city: element.city, province: element.province, postalCode: element.postalCode, country: element.country, isDefault: element.isDefault, phoneNumber: element.phoneNumber))
        }
        return arr
    }
    
    func translatePayment(from payment: [PaymentEntity]) -> [Payment] {
        var arr: [Payment] = []
        
        payment.forEach { (element) in
            arr.append(Payment(cardNumber: element.cardNumber, holderName: element.holderName, expiryDate: element.expiryDate, isDefault: element.isDefault))
        }
        return arr
    }
    
    func translateAddress(from address: Address) -> AddressEntity {
        return AddressEntity(receiver: address.receiver, address1: address.address1, address2: address.address2, city: address.city, province: address.province, postalCode: address.postalCode, country: address.country, isDefault: address.isDefault, phoneNumber: address.phoneNumber)
    }
    
    func translatePaymentModel(from payment: Payment) -> PaymentEntity {
        return PaymentEntity(cardNumber: payment.cardNumber, holderName: payment.holderName, expiryDate: payment.expiryDate, isDefault: payment.isDefault)
    }
}
