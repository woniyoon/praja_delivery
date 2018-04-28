//
//  AccountTranslator.swift
//  delivery
//
//  Created by Diego H. Vanni on 2018-03-12.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

class UserTranslator {
    func translate(fromEntity entity: UserEntity) -> User {
        return User(firstName: entity.firstName,
                    lastName: entity.lastName,
                    dateOfBirth: entity.dateOfBirth,
                    mobileNumber: entity.mobileNumber,
                    email: entity.email,
                    totalPoint: entity.totalPoint,
                    address: translateAddress(from: entity.address),
                    payment: translatePayment(from: entity.payment),
                    coupon: entity.coupon!)
    }

    func translate(fromModel model: User) -> UserEntity {
        return UserEntity(firstName: model.firstName, lastName: model.lastName, mobileNumber: model.mobileNumber, dateOfBirth: model.dateOfBirth, totalPoint: model.totalPoint, email: model.email, address: model.address.map({ translateAddress(from: $0)}), payment: model.payment.map({ translatePaymentModel(from: $0)}), coupon: model.coupon)!
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
    
//    func translateAddressEntity(address: AddressEntity) -> Address {
//        return Address(receiver: address.receiver, address1: address.address1, address2: address.address2, city: address.city, province: address.province, postalCode: address.postalCode, country: address.country, isDefault: address.isDefault, phoneNumber: address.phoneNumber)
//    }
//
}

