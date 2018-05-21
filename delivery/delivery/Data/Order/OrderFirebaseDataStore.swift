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
    
    func fetchOrder(with userId: String) -> Single<[OrderEntity]>{
        var arr = [OrderEntity]()
        return Single<[OrderEntity]>.create { observer -> Disposable in
                self.db.collection("order")
                    .whereField("userId", isEqualTo: userId)
                    .getDocuments{(documents, error) in
                if let error = error {
                    observer(.error(error))
                    return
                }
                if let docs = documents?.documents {
                    for doc in docs {
                        let order = OrderEntity(docId: doc.documentID, dictionary: doc.data())
                        print(order!.deliveryInfo.count) //all variables
                        arr.append(order!)
                    }
                }
                observer(.success(arr))
            }
            return Disposables.create()
        }
    }
    
    func fetchOrderDetail(with orderId: String) -> Single<OrderEntity> {
        return Single<OrderEntity>.create( subscribe: { observer in
            self.db
                .collection("order")
                .document(orderId)
                .getDocument(completion: { (snapshot, error) in
                    if let error = error {
                        observer(.error(error))
                    } else{
                        guard let doc = snapshot?.data() else{
                            observer(.error(NomnomError.alert(message: "no data")))
                            return
                        }
                        guard let order = OrderEntity(docId: orderId, dictionary: doc)
                            else{
                                observer(.error(NomnomError.alert(message: "Parse Failure")))
                                return
                        }
                        observer(.success(order))
                        
                    }
                })
            return Disposables.create()
        })
    }

    
}
