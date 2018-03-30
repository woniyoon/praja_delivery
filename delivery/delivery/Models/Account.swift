//
//  Account.swift
//  delivery
//
//  Created by Diego H. Vanni on 2018-03-26.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

// maybe not needed but who knows?

struct Account {
    public let firstName: String
    public let lastName: String
    public let dateOfBirth: String
    public let mobileNumber: String
    public let email: String
    public let totalPoint: Int
    public let address: [Address]
    public let payment: [Payment]
    public let token: String
    
    var dictionary: [String: Any] {
        return [
            "firstName": firstName,
            "lastName": lastName,
            "dateOfBirth": dateOfBirth,
            "mobileNumber": mobileNumber,
            "email": email,
            "totalPoint": totalPoint,
            "address": address,
            "payment": payment,
            "token": token
        ]
    }
}
