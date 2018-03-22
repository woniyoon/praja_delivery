//
//  ProductDetailFirebaseDataStore.swift
//  delivery
//
//  Created by Kento Uchida on 2018/02/24.
//  Copyright © 2018 CICCC. All rights reserved.
//
import Foundation
import Firebase
import RxSwift

class ProductDetailFirebaseDataStore: ProductDetailDataStoreProtocol {
    let db = Firestore.firestore()
    
    func fetchProductDetail(_ id: String) -> Single<ProductEntity> {
        return Single<ProductEntity>.create { observer -> Disposable in
            self.db.collection("products")
                .document(id)
                .getDocument { (document, error) in
                    if let error = error {
                        observer(.error(error))
                        return
                    }
                    guard let product = ProductEntity(dictionary: (document?.data())!) else {
                        return
                    }
                    observer(.success(product))
            }
            return Disposables.create()
        }
    }
}
