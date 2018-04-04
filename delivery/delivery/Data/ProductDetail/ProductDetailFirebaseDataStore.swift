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
            self.db.collection("product")
                .document(id)
                .getDocument { (document, error) in
                    if let error = error {
                        observer(.error(NomnomError.network(code: "", message: ErrorMsg.tryAgain, log: error.localizedDescription)))
                        return
                    }
                    guard let product = ProductEntity(docId: (document?.documentID)!, dictionary: (document?.data())!) else {
                        observer(.error(NomnomError.alert(message: "Parse Failure")))
                        return
                    }
                    observer(.success(product))
            }
            return Disposables.create()
        }
    }
}
