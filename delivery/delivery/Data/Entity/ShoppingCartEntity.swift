//
//  ShoppingCartEntity.swift
//  delivery
//
//  Created by Bacelar on 2018-04-05.
//  Copyright © 2018 CICCC. All rights reserved.
//

import RealmSwift

class ShoppingCartEntity: Object {
    
    @objc dynamic var id = 0
    @objc dynamic var quantity = 0
    let idProducts = List<String>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    
}
