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
                .document("oVhTC6TXjU1a3bG8EabF")
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
}
