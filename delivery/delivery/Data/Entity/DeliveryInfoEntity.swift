//
//  DeliveryInfoEntity.swift
//  delivery
//
//  Created by Jaewon Yoon on 2018-03-19.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

struct DeliveryInfoEntity {
    private let confirmedDate: Date?
    private let packedDate: Date?
    private let shippingDate: Date?
    private let deliveredDate: Date?
    private let canceledDate: Date?
    
    init?(dictionary: [String: Any]) {
        guard let confirmedDate = dictionary["confirmedDate"] as? Date,
            let packedDate = dictionary["packedDate"] as? Date,
            let shippingDate = dictionary["shippingDate"] as? Date, //this part...?
            let deliveredDate = dictionary["deliveredDate"] as? Date, // and this part.....!
            let canceledDate = dictionary["canceledDate"] as? Date else { return nil }
        
        self.confirmedDate = confirmedDate
        self.packedDate = packedDate
        self.shippingDate = shippingDate
        self.deliveredDate = deliveredDate
        self.canceledDate = canceledDate
    }
}
