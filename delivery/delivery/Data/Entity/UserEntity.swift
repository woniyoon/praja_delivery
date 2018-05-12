//
//  UserEntity.swift
//  delivery
//
//  Created by Sara N on 2018-03-12.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

struct UserEntity {
        public let firstName: String
        public let lastName: String
        public let dateOfBirth: Date?
        public let mobileNumber: String
        public let email: String
        public let totalPoint: Int
        public var address: [AddressEntity]?
        public let payment: [PaymentEntity]?
        public let coupon: [String : Bool]?


    init?(dictionary: [String: Any]) {
        guard let firstName = dictionary["firstName"] as? String,
            let lastName = dictionary["lastName"] as? String,
            let mobileNumber = dictionary["mobileNumber"] as? String, //this part...?
            let email = dictionary["email"] as? String,
            let totalPoint = dictionary["totalPoint"] as? Int else { return nil }
        
        let coupon = dictionary["coupon"] as? [String : Bool] ?? [:]
        
        
        if dictionary["address"] != nil {
            var addressArr: [AddressEntity]  = []
            for address in dictionary["address"] as! [Any] {
                addressArr.append(AddressEntity(dictionary: (address as? [String : Any]) ?? [:])!)
            }
            self.address = addressArr
        } else {
            self.address = nil
        }

        
        if dictionary["payment"] != nil {
            var paymentArr: [PaymentEntity] = []
            for payment in dictionary["payment"] as! [Any] {
                paymentArr.append(PaymentEntity(dictionary: (payment as? [String : Any]) ?? [:])!)
            }
            self.payment = paymentArr
        } else {
            self.payment = nil
        }
        
//        if dictionary["dateOfBirth"] != nil {
//            self.dateOfBirth =
//        }

        let dateOfBirth = dictionary["dateOfBirth"] as? Date ?? nil

        
        self.firstName = firstName
        self.lastName = lastName
        self.dateOfBirth = dateOfBirth
        self.totalPoint = totalPoint
        self.mobileNumber = mobileNumber
        self.email = email
        self.coupon = coupon
    }
    
    init?(firstName: String, lastName: String, mobileNumber: String, dateOfBirth: Date?, totalPoint: Int, email: String, address: [AddressEntity], payment: [PaymentEntity], coupon: [String : Bool]?) {
        self.firstName = firstName
        self.lastName = lastName
        self.mobileNumber = mobileNumber
        self.totalPoint = totalPoint
        self.email = email

//        var arrOfAddress: [AddressEntity] = []

//        address.forEach { (address) in
//            arrOfAddress.append(AddressEntity(receiver: address.receiver, address1: address.address1, address2: address.address2, city: address.city, province: address.province, postalCode: address.postalCode, country: address.country, isDefault: address.isDefault, phoneNumber: address.phoneNumber))
//        }

//        self.address = arrOfAddress

        self.address = address
        
//        var arrOfPayment: [PaymentEntity] = []
//
//        payment.forEach { (payment) in
//            arrOfPayment.append(PaymentEntity(cardNumber: payment.cardNumber, holderName: payment.holderName, expiryDate: payment.expiryDate, isDefault: payment.isDefault))
//        }

        self.payment = payment

        guard let dateOfBirth = dateOfBirth,
            let coupon = coupon else { return nil }
        
        self.dateOfBirth = dateOfBirth
        self.coupon = coupon
        self.address = address
    }
    
    var dictionary: [String: Any] {
        var dict: [String : Any] = [
            "firstName": firstName,
            "lastName": lastName,
            "mobileNumber": mobileNumber,
            "email": email,
            "address": (address != nil) ? address!.map { $0.dictionary } : [],
            "payment": (payment != nil) ? payment!.map { $0.dictionary } : [],
            "coupon": coupon ?? [:],
            "totalPoint": totalPoint
        ]
        if let dateOfBirth = dateOfBirth {
            dict["dateOfBirth"] = dateOfBirth
        }
        return dict

    }
}
