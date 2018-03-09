//
//  ProductListFirebaseDataStore.swift
//  delivery
//
//  Created by Bacelar on 2018-03-06.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import Firebase

class ProductListFirebaseDataStore: ProductListDataStoreProtocol {
    let db = Firestore.firestore()
    
    func fetchProductList() -> [ProductEntity] {
        var products:[ProductEntity] = []
        
        db.collection("product").order(by: "name")
        
        db.collection("product").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
            
                for document in querySnapshot!.documents {
                    if let dataProduct = document.data() as? Dictionary<String, AnyObject> {
                        
                        let name = dataProduct["name"]
                        let brand = dataProduct["brand"]
                        let description = dataProduct["description"]
                        let discountPercent = dataProduct["discountPercent"]
                        let subCategory = dataProduct["subCategory"]
                        let price = dataProduct["price"]
                        let images = dataProduct["images"]
                        
                        let product = ProductEntity(name: name as! String, description: description as! String, price: price as! Double, brand: brand as! String, discountPercent: discountPercent as! Int, subCategory: subCategory as! SubCategory, images: [images as! String])
                        
                        products.append(product)
                        
                    }
                                       
//                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
        
        return products
    }
    
    func addNewProduct(product: ProductEntity){
        
        print("Creating Product")

        let docData: [String: Any] = [
            "name": product.name!,
            "description": product.description!,
            "price": product.price!,
            "brand": product.brand!,
            "discountPercent": product.discountPercent!,
            "images": product.images!,
            "subCategory": [
                "name": product.subCategory!.name,
                "category": [
                    "name": product.subCategory!.category.name
                ]
            ]
        ]
        db.collection("product").document(product.name!).setData(docData) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
}
