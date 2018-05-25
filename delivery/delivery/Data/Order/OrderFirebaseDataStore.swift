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

        var orderDetail = [[String:Any]]()
        for item in order.orderDetail {
            
            orderDetail.append(["pricePerItem": item.pricePerItem,
                                "quantity": item.quantity,
                                "productId": item.productId,
                                "productImage": "https://images-na.ssl-images-amazon.com/images/I/61JPeeObrUL._SL1500_.jpg",
                                "productName": "Fanola"])
        }
        
        let pointStatement:[String:Any] = ["consumedPoints": order.pointStatement.consumedPoints,
                                           "earnedPoints": order.pointStatement.earnedPoints]
        
        let shippingAddress:[String:Any] = ["address1": order.shippingAddress.address1,
                                            "address2": order.shippingAddress.address2,
                                            "city": order.shippingAddress.city,
                                            "country": order.shippingAddress.country,
                                            "isDefault": order.shippingAddress.isDefault,
                                            "phoneNumber": order.shippingAddress.phoneNumber,
                                            "postalCode": order.shippingAddress.postalCode,
                                            "province": order.shippingAddress.province,
                                            "receiver": order.shippingAddress.receiver]
        
        let orderData: [String:Any] = ["cancelReason": order.cancelReason,
                                       "couponDiscount": 0,
                                       "deliveryFee": order.deliveryFee,
                                       "orderDetail": orderDetail,
                                       "orderNumber": order.orderNumber,
                                       "pointStatement":pointStatement,
                                       "remark": order.remark,
                                       "scheduledDeliveryDate": order.scheduledDeliveryDate,
                                       "shippingAddress": shippingAddress,
                                       "status": order.status.rawValue,
                                       "totalPrice": order.totalPrice,
                                       "trackingNumber": order.trackingNumber,
                                       "userId": user.uid,
                                       "deliveryInfo": order.deliveryInfo]
        
        // TODO: CHECK WITH KENTO WHY COMPLETABLE IS NOT WORKING
        
         self.db.collection(ORDER_COLLECTION)
            .addDocument(data: orderData) { err in
                if let err = err {
                    print(err)
                } else {
                    print("Completed")
                }
        }
        
        
        
        return Completable.create { completable in

//            self.db.collection(ORDER_COLLECTION)
//                .addDocument(data: orderData) { err in
//                    if let err = err {
//                        print("error")
//                        completable(.error(NomnomError.alert(message: "Failed for some reasons!\n\(err.localizedDescription)")))
//                    } else {
//                        print("completed")
//                        completable(.completed)
//                    }
//            }
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
