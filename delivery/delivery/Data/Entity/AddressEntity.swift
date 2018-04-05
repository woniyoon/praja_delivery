//
//  AccountEntity.swift
//  delivery
//
//  Created by Diego H. Vanni on 2018-03-25.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

struct AddressEntity {
    public let receiver: String
    public let address1: String
    public let address2: String
    public let city: String
    public let province: String
    public let postalCode: String
    public let country: String
    
    var dictionary: [String: Any] {
        return [
            "receiver": receiver,
            "address1": address1,
            "address2": address2,
            "city": city,
            "province": province,
            "postalCode": postalCode,
            "country": country
        ]
    }
    
    init?(dictionary: [String: Any]) {
        guard let receiver = dictionary["receiver"] as? String,
            let address1 = dictionary["address1"] as? String,
            let address2 = dictionary["address2"] as? String,
            let city = dictionary["city"] as? String,
            let province = dictionary["province"] as? String,
            let postalCode = dictionary["postalCode"] as? String,
            let country = dictionary["country"] as? String else { return nil }
        
        self.receiver = receiver
        self.address1 = address1
        self.address2 = address2
        self.city = city
        self.province = province
        self.postalCode = postalCode
        self.country = country
    }
}
