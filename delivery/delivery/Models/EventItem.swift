//
//  EventItem.swift
//  delivery
//
//  Created by Sara N on 2018-02-20.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

class EventItem{
    
    var eventId: String
    var productId: String
    
    init(eventId: String, productId: String) {
        self.eventId = eventId
        self.productId = productId
    }
}

