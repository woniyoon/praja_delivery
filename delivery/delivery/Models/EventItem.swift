//
//  EventItem.swift
//  delivery
//
//  Created by Sara N on 2018-02-20.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

class EventItem{
    
    var event: Event
    var productId: String
    
    init(event: Event, productId: String) {
        self.event = event
        self.productId = productId
    }
}

