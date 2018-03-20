//
//  HomeFirebaseDataStore.swift
//  delivery
//
//  Created by Jaewon Yoon on 2018-03-12.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import Firebase

class HomeFirebaseDataStore: HomeDataStoreProtocol {
    let db = Firestore.firestore()
    
    func fetchProducts() -> ProductEntity {
        let result = db.collection("productFromSpreadSheet").whereField("name", isEqualTo: "pepsi6 250ml")
        print("loading...")
        print(result)

        var product: Dictionary<String, Any> = [:]
        
        product = ["name": "Salad",
                                "price": 2.19,
                                "originalPrice": 1.50] as [String : Any]
        
        return ProductEntity(dictionary: product)!
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
}
