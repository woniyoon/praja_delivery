//
//  Extention.swift
//  delivery
//
//  Created by Kento Uchida on 2018/02/24.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation

extension DateFormatter {
    static func birthDateInFormat (birthDate: Date) -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd yyyy"
        return dateFormatterPrint.string(from: birthDate)
    }
    
    static func expiryDateInFormat (expiryDate: Date) -> String {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MM/yy"
        return dateFormatterPrint.string(from: expiryDate)
    }
    
    static func toDateFromString (date: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd yyyy" //Your date format
        dateFormatter.timeZone = TimeZone(identifier: "America/Los_Angeles") //Current time zone
        print("converting!!")
        return dateFormatter.date(from: date)
    }
}

