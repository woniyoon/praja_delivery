//
//  ProductDetailFirebaseDataStore.swift
//  delivery
//
//  Created by Kento Uchida on 2018/02/24.
//  Copyright © 2018 CICCC. All rights reserved.
//
import Foundation
import Firebase

class ProductDetailFirebaseDataStore: ProductDetailDataStoreProtocol {
    let db = Firestore.firestore()
    
    func fetchProductDetail(_ id: String, _ err: (Error) -> Void, callback: @escaping (SampleProductEntity) -> Void) {
        db.collection("sample_product")
            .document(id)
            .getDocument { (document, error) in
                guard let product = SampleProductEntity(dictionary: (document?.data())!) else {
                    return
                }
                callback(product)
        }
    }
}
