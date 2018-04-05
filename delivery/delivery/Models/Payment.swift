//
//  AccountEntity.swift
//  delivery
//
//  Created by Diego H. Vanni on 2018-03-25.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import RxDataSources

struct Payment {
    public let cardNumber: String
    public let holderName: String
    public let expiryDate: String
    
    var dictionary: [String: Any] {
        return [
            "cardNumber": cardNumber,
            "holderName": holderName,
            "expiryDate": expiryDate,
        ]
    }
}

struct SectionOfPayment {
    var header: String
    var items: [Item]
}
extension SectionOfPayment: SectionModelType {
    typealias Item = Payment
    
    init(original: SectionOfPayment, items: [Item]) {
        self = original
        self.items = items
    }
}
