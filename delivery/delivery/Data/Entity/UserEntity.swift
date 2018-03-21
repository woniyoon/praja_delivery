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
    public let mobileNumber: String
    public let dateOfBirth: Date
    public let hasAccount: Bool
    public let totalPoint: Int
    public let email: String
    public let address: [AddressEntity]
    public let payment: [PaymentEntity]
    public let coupon: [String : Bool]

    init?(dictionary: [String: Any]) {
        guard let firstName = dictionary["firstName"] as? String,
            let lastName = dictionary["lastName"] as? String,
            let mobileNumber = dictionary["mobileNumber"] as? String, //this part...?
            let dateOfBirth = dictionary["dateOfBirth"] as? Date, // and this part.....!
            let hasAccount = dictionary["hasAccount"] as? Bool,
            let totalPoint = dictionary["totalPoint"] as? Int,
            let email = dictionary["email"] as? String,
            let coupon = dictionary["coupon"] as? [String : Bool],
            let address = dictionary["address"] as? [AddressEntity],
            let payment = dictionary["payment"] as? [PaymentEntity] else { return nil }
        
        self.firstName = firstName
        self.lastName = lastName
        self.mobileNumber = mobileNumber
        self.dateOfBirth = dateOfBirth
        self.hasAccount = hasAccount
        self.totalPoint = totalPoint
        self.email = email
        self.coupon = coupon
        self.address = address
        self.payment = payment
    }
    
    var dictionary: [String: Any] {
        return [
            "firstName": firstName,
            "lastName": lastName,
            "mobileNumber": mobileNumber,
            "dateOfBirth": dateOfBirth,
            "hasAccount": hasAccount,
            "email": email,
            "address": address,
            "payment": payment,
            "coupon": coupon,
            "totalPoint": totalPoint
        ]
    }
}
