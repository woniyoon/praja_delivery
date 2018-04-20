//
//  ShoppingCartDataStore.swift
//  delivery
//
//  Created by Bacelar on 2018-04-05.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import RxSwift
import Realm
import RealmSwift
import RxCocoa
import RxRealm
import Firebase

class ShoppingCartDataStore: ShoppingCartDataStoreProtocol {
    let db = Firestore.firestore()
    
    func deleteShoppingCart() {
        let realm = RealmManager.sharedInstance
        realm.deleteAllFromDatabase()
    }
    
    func addProductShoppingCart(shoppingCart: ShoppingCartEntity) {
        let realm = RealmManager.sharedInstance
        print("Realm - \(shoppingCart.id)")
        
         shoppingCart.id = String(realm.getNewId(type: ShoppingCartEntity.self)!)
        realm.addData(object: shoppingCart)
    }
        
    func fetchShoppingCart() -> Single<[ProductShoppingCartEntity]> {
        let realm = RealmManager.sharedInstance
        
        return Single<[ProductShoppingCartEntity]>.create { observer -> Disposable in
            
            var arr = [ProductShoppingCartEntity]()
            var counter = 0
            let size = realm.getData(type: ShoppingCartEntity.self)!.count
            for carItem in realm.getData(type: ShoppingCartEntity.self)! {
                
                let cartItem = carItem as! ShoppingCartEntity
                
                self.db.collection("product")
                    .document(cartItem.idProducts)
                    .getDocument { (document, error) in
                        if let error = error {
                            observer(.error(NomnomError.network(code: "", message: ErrorMsg.tryAgain, log: error.localizedDescription)))
                            return
                        }
                        
                        if let product = ProductEntity(docId: (document?.documentID)!, dictionary: (document?.data())!)
                        {
                            arr.append(ProductShoppingCartEntity(product: product,quantity: 1))
                            
                        }
                        else {
                            observer(.error(NomnomError.alert(message: "Parse Failure")))
                            return
                        }
                        counter = counter + 1
                        if counter >= size {
                            observer(.success(arr))
                        }
                }
            }
            return Disposables.create()
        }
    }
}

