//
//  ProductListFirebaseDataStore.swift
//  delivery
//
//  Created by Bacelar on 2018-03-06.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import Firebase
import RxSwift

class ProductListFirebaseDataStore: ProductListDataStoreProtocol {

    let db = Firestore.firestore()
    
    func fetchProductList() -> [SampleProductEntity] {
        
        var products:[SampleProductEntity] = []
        
        db.collection("sample_product")
            .getDocuments() { (document, error) in
                if let error = error {
                   print(error)
                    return
                }
                for document in document!.documents {
                    if (document.data() as? Dictionary<String, AnyObject>) != nil {
                        guard let product = SampleProductEntity(dictionary: document.data()) else { return }
                        print("Product name \(product.name)")
                        products.append(product)
                    }
                    
                }
        }
        
        return products
    }
}
