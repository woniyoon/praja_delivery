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
        db.collection("product")
            .getDocuments(completion: { (document, error) in
                if let error = error {
                    return
                }
                for document in document!.documents {
                    if (document.data() as? Dictionary<String, AnyObject>) != nil {
                        guard let product = ProductEntity(docId: document.documentID, dictionary: document.data()) else {
                            return
                        }
                        print("Product name from storyboard: \(product.name)")
                        products.append(product)
                    }
                    
                }
            })
        
        return products
    }
    
    
    func fetchProductList(with keyword: String) -> Single<[ProductEntity]> {
        var arr = [ProductEntity]()
        return Single<[ProductEntity]>.create { observer -> Disposable in
                let products = self.db.collection("product")

                products.getDocuments { (documents, error) in
                if let error = error {
                    observer(.error(error))
                    return
                }
                if let docs = documents?.documents {
                    for doc in docs {
                        let name = doc.data()["name"] as! String
                        
                        if keyword != "" {
                            if name.lowercased().range(of:keyword.lowercased()) != nil {
                                let product = ProductEntity(docId: doc.documentID, dictionary: (doc.data()))
                                arr.append(product!)
                            }
                        } else {
                            let product = ProductEntity(docId: doc.documentID, dictionary: (doc.data()))
                            arr.append(product!)
                        }
                    }
                }
                observer(.success(arr))
            }
            return Disposables.create()
        }
    }
}
