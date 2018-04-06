//
//  ShoppingCartDataStore.swift
//  delivery
//
//  Created by Bacelar on 2018-04-05.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import RxSwift

class ShoppingCartDataStore: ShoppingCartDataStoreProtocol {
    
    func addProductShoppingCart(shoppingCart: ShoppingCartEntity) {
        let realm = RealmManager.sharedInstance
        realm.addData(object: shoppingCart)
    }
    
    
//    func fetchShoppingCart() -> [ProductEntity] {
//        
//        
//        return [ProductEntity]()
//    }
}

