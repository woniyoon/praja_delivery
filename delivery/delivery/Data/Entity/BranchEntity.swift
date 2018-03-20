//
//  BranchEntity.swift
//  delivery
//
//  Created by Jaewon Yoon on 2018-03-18.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

struct BranchEntity {
    public let address: String
    public let city: String
    public let latitude: Float
    public let longitude: Float
    public let name: String
    public let phoneNumber: String
    public let postalCode: String
    public let province: String
    
    init?(dictionary: [String: Any]) {
        guard let address = dictionary["address"] as? String,
            let city = dictionary["city"] as? String,
            let latitude = dictionary["latitude"] as? Float, //this part...?
            let longitude = dictionary["longitude"] as? Float, // and this part.....!
            let name = dictionary["name"] as? String,
            let phoneNumber = dictionary["phoneNumber"] as? String,
            let postalCode = dictionary["postalCode"] as? String,
            let province = dictionary["province"] as? String else { return nil }
        
        self.address = address
        self.city = city
        self.latitude = latitude
        self.longitude = longitude
        self.name = name
        self.phoneNumber = phoneNumber
        self.postalCode = postalCode
        self.province = province
    }
    
//    var dictionary: [String: Any] {
//        return [
//            "name": name,
//            "latitude": latitude,
//            "longitude": longitude,
//            "address": address,
//            "city": city,
//            "province": province,
//            "postalCode": postalCode,
//            "phoneNumber": phoneNumber
//        ]
//    }
}
