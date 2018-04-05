//
//  AccountEntity.swift
//  delivery
//
//  Created by Diego H. Vanni on 2018-03-25.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

struct Address {
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
}

struct SectionOfAddress {
    var header: String
    var items: [Item]
}
extension SectionOfAddress: SectionModelType {
    typealias Item = Address
    
    init(original: SectionOfAddress, items: [Item]) {
        self = original
        self.items = items
    }
}
