//
//  AccountEntity.swift
//  delivery
//
//  Created by Diego H. Vanni on 2018-03-25.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

struct AccountEntity {
        public let firstName: String
        public let lastName: String
        public let fullName: String
        public let dateOfBirth: Date?
        public let mobileNumber: String
        public let email: String
        public let totalPoint: Int
        public let address: [AddressEntity]
        public let payment: [PaymentEntity]
        public let token: String
    
    
    init?(dictionary: [String: Any]) {
        guard let firstName = dictionary["firstName"] as? String,
            let lastName = dictionary["lastName"] as? String,
            let dateOfBirth = dictionary["dateOfBirth"] as? Date?,
            let mobileNumber = dictionary["mobileNumber"] as? String,
            let email = dictionary["email"] as? String,
            let totalPoint = dictionary["totalPoint"] as? Int,
//            let address = dictionary["address"] as? [Address],
//            let payment = dictionary["payment"] as? [Payment],
            let token = dictionary["token"] as? String else { return nil }

        var temp: [AddressEntity]  = []
        for address in dictionary["address"] as! [Any] {
            temp.append(AddressEntity(dictionary: (address as? [String : Any]) ?? [:])!)
        }
        self.address = temp

        var temp2: [PaymentEntity]  = []
        for payment in dictionary["payment"] as! [Any] {
            temp2.append(PaymentEntity(dictionary: (payment as? [String : Any]) ?? [:])!)
        }
        self.payment = temp2
        
        self.firstName = firstName
        self.lastName = lastName
        self.fullName = ("\(firstName) \(lastName)")
        self.dateOfBirth = dateOfBirth
        self.mobileNumber = mobileNumber
        self.email = email
        self.totalPoint = totalPoint
        self.token = token
    }
    
}

