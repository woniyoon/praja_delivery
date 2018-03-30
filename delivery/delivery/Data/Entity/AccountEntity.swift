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
        public let dateOfBirth: String
        public let mobileNumber: String
        public let email: String
        public let totalPoint: Int
        public let address: [Address]
        public let payment: [Payment]
        public let token: String
    
    
    init?(dictionary: [String: Any]) {
        guard let firstName = dictionary["firstName"] as? String,
            let lastName = dictionary["lastName"] as? String,
            let dateOfBirth = dictionary["dateOfBirth"] as? String,
            let mobileNumber = dictionary["mobileNumber"] as? String,
            let email = dictionary["email"] as? String,
            let totalPoint = dictionary["totalPoint"] as? Int,
            let address = dictionary["address"] as? [Address],
            let payment = dictionary["payment"] as? [Payment],
            let token = dictionary["token"] as? String else { return nil }

        
        self.firstName = firstName
        self.lastName = lastName
        self.dateOfBirth = dateOfBirth
        self.mobileNumber = mobileNumber
        self.email = email
        self.totalPoint = totalPoint
        self.address = address
        self.payment = payment
        self.token = token
    }
    
}

