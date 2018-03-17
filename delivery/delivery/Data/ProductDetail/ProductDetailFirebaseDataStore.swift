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
    
    func fetchProductDetail(_ id: String, callback: (ProductEntity, Error) -> Void) {
        let db = Firestore.firestore()
        db.collection("sample_product")
            .document(id)
            .getDocument { (document, error) in
                print(error)
                print(document!)
        }
    }
}
