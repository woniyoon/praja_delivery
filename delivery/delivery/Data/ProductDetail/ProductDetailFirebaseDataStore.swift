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
    
    func fetchProductDetail(_ id: String) -> Single<SampleProductEntity> {
        return Single<SampleProductEntity>.create { observer -> Disposable in
            self.db.collection("sample_product")
                .document(id)
                .getDocument { (document, error) in
                    if let error = error {
                        observer(.error(error))
                        return
                    }
                    guard let product = SampleProductEntity(dictionary: (document?.data())!) else {
                        observer(.error(NomnomError.failedParse))
                        return
                    }
                    observer(.success(product))
            }
            return Disposables.create()
        }
    }
}
