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
                        print(document?.data()!)
                        observer(.error(error!))
                        return
                    }
                    observer(.success(product))
            }
            return Disposables.create()
        }
    }
    
//    func fetchProducts() -> ProductEntity {
//        return ProductEntity(
//            name: "Salad",
//            brand: "",
//            price: 9.00,
//            originalPrice: 10.00,
//            discountPercent: 10,
//            images: [""],
//            averageRating: 3,
//            fiveStarsCount: 2,
//            fourStarsCount: 3,
//            threeStarsCount: 8,
//            twoStarsCount: 3,
//            oneStarCount: 2,
//            description:
//            """
//            Are you tired of slow, inefficient charging with too many wires that get tangled with each other?
//
//            If you are, we have just the solution for you!
//
//            Combining super-fast charging and wireless technology, Ivolks is proud to present…
//            """,
//            category: "Food",
//            subCategory: "Sweet")
//    }
//}

}
