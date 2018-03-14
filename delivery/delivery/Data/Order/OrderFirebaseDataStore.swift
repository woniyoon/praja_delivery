//
//  DeliveryFirebaseDataStore.swift
//  delivery
//
//  Created by MATSUHISA MAI on 2018/03/12.
//  Copyright © 2018年 CICCC. All rights reserved.
//

import Foundation
import Firebase

class OrderFirebaseDataStore: OrderDataStoreProtocol {
    //slet db = Firestore.firestore()
    
    func fetchOrder(_ id: String) -> ProductEntity{
//            let productRef = db.collection("productFromSpreadSheet").document("Sour Patch Kids Sweet and Sour Gummy Candy (Strawberry, 10 Ounce Bag, Pack of 12)")
        
            return ProductEntity( //OrderEntity(
            name: "Sour Patch Kids Sweet and Sour Gummy Candy (Strawberry, 10 Ounce Bag, Pack of 12)",
            brand: "",
            price: 13.87,
            originalPrice: 15.00,
            discountPercent: 10,
            images: [""],
            averageRating: 3,
            fiveStarsCount: 2,
            fourStarsCount: 3,
            threeStarsCount: 8,
            twoStarsCount: 3,
            oneStarCount: 2,
            description:
            """
            Are you tired of slow, inefficient charging with too many wires that get tangled with each other?

            If you are, we have just the solution for you!

            Combining super-fast charging and wireless technology, Ivolks is proud to present…
            """,
            category: "Food",
            subCategory: "Sweet")
    }
}
