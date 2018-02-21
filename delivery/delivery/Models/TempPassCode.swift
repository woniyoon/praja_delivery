//
//  TempPassCode.swift
//  delivery
//
//  Created by Sara N on 2018-02-20.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

class TempPassCode{
    
    var passCode: String
    var userId: String
    var expiryDate: Date
    
    init(passCode: String, userId: String, expiryDate: Date) {
        self.passCode = passCode
        self.userId = userId
        self.expiryDate = expiryDate
    }
}
