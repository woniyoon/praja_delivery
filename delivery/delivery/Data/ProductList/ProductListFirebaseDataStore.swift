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
    
    func fetchProductList(with keyword: String, by orderby: String, _ descending: Bool) -> Single<[ProductEntity]> {
        var arr = [ProductEntity]()
        return Single<[ProductEntity]>.create { observer -> Disposable in
                let products = self.db.collection("product").order(by: orderby, descending: descending)

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
