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
//        let result = db.collection("productFromSpreadSheet").whereField("name", isEqualTo: "pepsi6 250ml")
//        print("loading...")
//        print(result)
//
//        return ProductEntity(
//                    name: "Salad",
//                    brand: "",
//                    price: 9.00,
//                    originalPrice: 10.00,
//                    discountPercent: 10,
//                    images: [""],
//                    averageRating: 3,
//                    fiveStarsCount: 2,
//                    fourStarsCount: 3,
//                    threeStarsCount: 8,
//                    twoStarsCount: 3,
//                    oneStarCount: 2,
//                    description:
//                    """
//                    Are you tired of slow, inefficient charging with too many wires that get tangled with each other?
//                    If you are, we have just the solution for you!
//                    Combining super-fast charging and wireless technology, Ivolks is proud to present…
//                    """,
//                    category: "Food",
//                    subCategory: "Sweet")
        
        var result: ProductEntity
        db.collection("products").whereField("brand", isEqualTo: "Kraft").getDocuments { (snapshot, err) in
            
            if let error = err {
                print(error)
            } else {
                if let docs = snapshot?.documents {
                    for doc in docs {
                        result = ProductEntity(name: doc.data()["name"] as! String, description: doc.data()["description"] as! String, price: doc.data()["price"] as! Double, originalPrice: Double(doc.data()["discountPercent"] as! Int), brand: doc.data()["brand"] as! String, subCategory: SubCategory(name: doc.data()["subcategory"] as! String, category: Category(name: doc.data()["category"] as! String)), images: doc.data()["images"] as! [String], averageRating: 5, event: nil, branch: ["Downtown": BranchInvetory(quantity: 40, name: "name")])
                    }
                }
            }
        }
        return result
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
