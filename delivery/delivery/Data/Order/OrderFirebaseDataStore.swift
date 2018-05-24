//
//  DeliveryFirebaseDataStore.swift
//  delivery
//
//  Created by MATSUHISA MAI on 2018/03/12.
//  Copyright © 2018年 CICCC. All rights reserved.
//

import Foundation
import Firebase
import RxSwift

class OrderFirebaseDataStore: OrderDataStoreProtocol {
    
    let db = Firestore.firestore()

    func saveOrder(_ order: OrderEntity) -> Completable {
        guard let user = Auth.auth().currentUser else {
            return Completable.empty()
        }
        
        return Completable.create { observer in
            self.db.collection(ORDER_COLLECTION)
                .addDocument(data: order.dictionary) { err in
                    if let err = err {
                        observer(.error(NomnomError.alert(message: "Failed for some reasons!\n\(err.localizedDescription)")))
                    } else {
                        observer(.completed)
                    }
            }
            return Disposables.create()
        }
    }
    
    func fetchOrder(_ id: String) -> Single<OrderEntity>{
        
        return Single<OrderEntity>.create { observer -> Disposable in
            self.db.collection("order")
                .whereField("userId", isEqualTo: id)
                .getDocuments() { (document, error) in
                    if let error = error {
                        observer(.error(error))
                        return
                    }
                    guard let product = OrderEntity(dictionary: (document?.documents[0].data())!) else {
                        observer(.error(error!))
                        return
                    }
                    observer(.success(product))
            }
            return Disposables.create()
        }
    }
}
