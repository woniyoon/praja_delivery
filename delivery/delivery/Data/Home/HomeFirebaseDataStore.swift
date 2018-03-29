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

class HomeFirebaseDataStore: HomeDataStoreProtocol {
    let db = Firestore.firestore()
    
    func fetchProducts() -> Single<ProductEntity> {
        return Single<ProductEntity>.create { observer -> Disposable in
            self.db.collection("products")
                .document("icfXqPvflmrFFjQQAijp")
                .getDocument { (document, error) in
                    if let error = error {
                        observer(.error(error))
                        return
                    }
                    guard let product = ProductEntity(dictionary: (document?.data())!) else {
                        observer(.error(error!))
                        return
                    }
                    observer(.success(product))
            }
            return Disposables.create()
        }
    }
    
    func fetchArrayOfProduct() -> Single<[ProductEntity]> {
        var arr = [ProductEntity]()
        return Single<[ProductEntity]>.create { observer -> Disposable in
            self.db.collection("product").getDocuments { (documents, error) in
                if let error = error {
                    observer(.error(error))
                    return
                }
                if let docs = documents?.documents {
                    for doc in docs {
                        let product = ProductEntity(dictionary: (doc.data()))
                        print(product?.name)
                        arr.append(product!)
                    }
                }
                observer(.success(arr))
            }
            return Disposables.create()
        }
    }
}
