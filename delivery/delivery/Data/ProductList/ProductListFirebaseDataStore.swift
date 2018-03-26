//
//  HomeFirebaseDataStore.swift
//  delivery
//
//  Created by Jaewon Yoon on 2018-03-12.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import Firebase
import RxSwift

class ProductListFirebaseDataStore: ProductListDataStoreProtocol {

    let db = Firestore.firestore()
    
    func fetchProductList2() -> [ProductEntity] {
        
        var products = [ProductEntity]()
        db.collection("products")
            .getDocuments(completion: { (document, error) in
                if let error = error {
                    return
                }
                for document in document!.documents {
                    if (document.data() as? Dictionary<String, AnyObject>) != nil {
                        guard let product = ProductEntity(dictionary: document.data()) else {
                            return
                        }
                        print("Product name from storyboard: \(product.name)")
                        products.append(product)
                    }
                    
                }
            })
        
        return products
    }
    
    
    func fetchProductList() -> Single<[ProductEntity]> {
        
        var products = [ProductEntity]()
        return Single<[ProductEntity]>.create { observer -> Disposable in
            self.db.collection("products")
                .getDocuments(completion: { (document, error) in
                    if let error = error {
                        observer(.error(NomnomError.network(code: "", message: ErrorMsg.tryAgain, log: error.localizedDescription)))
                        return
                    }

                    for document in document!.documents {
                        if (document.data() as? Dictionary<String, AnyObject>) != nil {
                            guard let product = ProductEntity(dictionary: document.data()) else {
                                observer(.error(NomnomError.alert(message: "Parse Failure")))
                                return
                            }
                            print("Product name from storyboard: \(product.name)")
                            products.append(product)
                        }
                        
                        observer(.success(products))
                    }
                })

            return Disposables.create()
        }
    }
}
