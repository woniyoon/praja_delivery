//
//  UserCoupon.swift
//  delivery
//
//  Created by Jaewon Yoon on 2018-02-20.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

class UserCoupon {
    private let coupon : Coupon
    //change the type to User
    private let userId : String
    
    init(coupon : Coupon, userId : String) {
        self.coupon = coupon
        self.userId = userId
    }
}
