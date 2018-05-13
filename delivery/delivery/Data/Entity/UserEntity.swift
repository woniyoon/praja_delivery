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
            let mobileNumber = dictionary["mobileNumber"] as? String,
            let email = dictionary["email"] as? String,
            let totalPoint = dictionary["totalPoint"] as? Int else { return nil }
        
        let coupon = dictionary["coupon"] as? [String : Bool] ?? [:]
    
        if dictionary["address"] is NSNull && dictionary["address"] != nil {
            self.address = nil
        } else {
            var addressArr: [AddressEntity]  = []
            for address in dictionary["address"] as! [Any] {
                addressArr.append(AddressEntity(dictionary: (address as? [String : Any]) ?? [:])!)
            }
            self.address = addressArr
        }

        if dictionary["payment"] is NSNull || dictionary["payment"] == nil {
            self.payment = nil
        } else {
            var paymentArr: [PaymentEntity] = []
            for payment in dictionary["payment"] as! [Any] {
                paymentArr.append(PaymentEntity(dictionary: (payment as? [String : Any]) ?? [:])!)
            }
            self.payment = paymentArr
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
    
    init(firstName: String, lastName: String, mobileNumber: String, dateOfBirth: Date?, totalPoint: Int, email: String, address: [AddressEntity]?, payment: [PaymentEntity]?, coupon: [String : Bool]?) {
        self.firstName = firstName
        self.lastName = lastName
        self.mobileNumber = mobileNumber
        self.totalPoint = totalPoint
        self.email = email
        self.dateOfBirth = dateOfBirth
        self.coupon = coupon
        self.address = address
        self.payment = payment
    }
    
    var dictionary: [String: Any] {
        var dict: [String : Any] = [
            "firstName": firstName,
            "lastName": lastName,
            "mobileNumber": mobileNumber,
            "email": email,
            "address": (address != nil) ? address!.map { $0.dictionary } : nil,
            "payment": (payment != nil) ? payment!.map { $0.dictionary } : nil,
            "coupon": coupon ?? [:],
            "totalPoint": totalPoint
        ]
        if let dateOfBirth = dateOfBirth {
            dict["dateOfBirth"] = dateOfBirth
        }
        return dict

    }
}
