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
    
    func addProductShoppingCart(shoppingCart: ShoppingCartEntity) {
        let realm = RealmManager.sharedInstance
        print("Realm - \(shoppingCart.id)")
        
        shoppingCart.id = realm.getNewId(type: ShoppingCartEntity.self)!
        realm.addData(object: shoppingCart)
    }

    
    //            for carItem in realm.getData(type: ShoppingCartEntity.self)! {
    //                let cartItem = carItem as! ShoppingCartEntity
    //
    //                print("id Product \(cartItem.idProducts)")
    //
    //            }
    
    func fetchShoppingCart() -> Single<[ProductShoppingCartEntity]> {
        let realm = RealmManager.sharedInstance
            
        return Single<[ProductShoppingCartEntity]>.create { observer -> Disposable in
            
            var arr = [ProductShoppingCartEntity]()
            self.db.collection("product")
                .document("MV8uokn9iBHsURCOzWdM")
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
                observer(.success(arr))
            }
            return Disposables.create()
        }
    }
}
