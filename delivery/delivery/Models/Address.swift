//
//  Address.swift
//  delivery
//
//  Created by Jaewon Yoon on 2018-02-20.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

enum country {
    case CAN
}

enum province {
    case AB
    case BC
}

class Address {
    private(set) public var address_1 : String
    private(set) public var address_2 : String
    private(set) public var city : String
    private(set) public var province : province
    private(set) public var postalCode : String
    private(set) public var country : country
    
    init (add1 : String, add2 : String, city : String, province : province, postalCode : String, country : country) {
        self.address_1 = add1
        self.address_2 = add2
        self.city = city
        self.province = province
        self.postalCode = postalCode
        self.country = country
    }
}
