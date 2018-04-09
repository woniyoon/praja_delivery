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
    public let dateOfBirth: Date?
    public let totalPoint: Int
    public let email: String
    public let address: [AddressEntity]
    public let payment: [PaymentEntity]
    public let coupon: [String : Bool]

    init?(dictionary: [String: Any]) {
        guard let firstName = dictionary["firstName"] as? String,
            let lastName = dictionary["lastName"] as? String,
            let mobileNumber = dictionary["mobileNumber"] as? String,
            let email = dictionary["email"] as? String,
            let totalPoint = dictionary["totalPoint"] as? Int else { return nil }
        
        
        let dateOfBirth = dictionary["dateOfBirth"] as? Date ?? nil
        let coupon = dictionary["coupon"] as? [String : Bool] ?? [:]
        
        var temp: [AddressEntity]  = []
        for address in dictionary["address"] as! [Any] {
            temp.append(AddressEntity(dictionary: (address as? [String : Any]) ?? [:])!)
        }
        self.address = temp
        
        var paymentArr: [PaymentEntity] = []
        for payment in dictionary["payment"] as! [Any] {
            paymentArr.append(PaymentEntity(dictionary: (payment as? [String : Any]) ?? [:])!)
        }
        
        self.payment = paymentArr
        
        self.firstName = firstName
        self.lastName = lastName
        self.mobileNumber = mobileNumber
        self.dateOfBirth = dateOfBirth
        self.totalPoint = totalPoint
        self.email = email
        self.coupon = coupon
    }
    
    var dictionary: [String: Any] {
        return [
            "firstName": firstName,
            "lastName": lastName,
            "mobileNumber": mobileNumber,
            "dateOfBirth": dateOfBirth as Any,
            "email": email,
            "address": address,
            "payment": payment,
            "coupon": coupon,
            "totalPoint": totalPoint
        ]
    }
}
