//
//  ShoppingCart.swift
//  deliveryciccc
//
//  Created by Bacelar on 2018-02-19.
//

import RealmSwift

class ShoppingCart: Object {
    @objc dynamic var id = 0
    @objc dynamic var quantity = 0
    let idProducts = List<String>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
