//
//  Address.swift
//  delivery
//
//  Created by Jaewon Yoon on 2018-02-20.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

enum Country {
    case CAN
}

enum Province {
    case AB
    case BC
}

class Address {
    private(set) public var address_1 : String
    private(set) public var address_2 : String
    private(set) public var city : String
    private(set) public var province : Province
    private(set) public var postalCode : String
    private(set) public var country : Country
    
    init (add1 : String, add2 : String, city : String, province : Province, postalCode : String, country : Country) {
        self.address_1 = add1
        self.address_2 = add2
        self.city = city
        self.province = province
        self.postalCode = postalCode
        self.country = country
    }
}
