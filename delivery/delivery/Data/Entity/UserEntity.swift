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
    
        if !(dictionary["address"] is NSNull), let addresses = dictionary["address"] as? [Any] {
            self.address = addresses.map({ address in
                AddressEntity(dictionary: (address as? [String : Any]) ?? [:])!
            })
        } else {
            self.address = nil
        }
        
        if !(dictionary["payment"] is NSNull), let payments = dictionary["payment"] as? [Any] {
            self.payment = payments.map({ payment in
                PaymentEntity(dictionary: (payment as? [String : Any]) ?? [:])!
            })
        } else {
            self.payment = nil
        }

        self.firstName = dictionary["firstName"] as? String ?? ""
        self.lastName = dictionary["lastName"] as? String ?? ""
        self.dateOfBirth = dictionary["dateOfBirth"] as? Date ?? nil
        self.totalPoint = dictionary["totalPoint"] as? Int ?? 0
        self.mobileNumber = dictionary["mobileNumber"] as? String ?? ""
        self.email = dictionary["email"] as? String ?? ""
        self.coupon = dictionary["coupon"] as? [String : Bool] ?? [:]
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
            "address": address?.map { $0.dictionary } as Any,
            "payment": payment?.map { $0.dictionary } as Any,
            "coupon": coupon ?? [:],
            "totalPoint": totalPoint
        ]
        if let dateOfBirth = dateOfBirth {
            dict["dateOfBirth"] = dateOfBirth
        }
        return dict
    }
}
