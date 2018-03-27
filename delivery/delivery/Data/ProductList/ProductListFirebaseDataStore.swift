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
        var arr = [ProductEntity]()
        return Single<[ProductEntity]>.create { observer -> Disposable in
            self.db.collection("products").getDocuments { (documents, error) in
                if let error = error {
                    observer(.error(error))
                    return
                }
                if let docs = documents?.documents {
                    for doc in docs {
                        let product = ProductEntity(dictionary: (doc.data()))
                        arr.append(product!)
                    }
                }
                observer(.success(arr))
            }
            return Disposables.create()
        }
    }
}
