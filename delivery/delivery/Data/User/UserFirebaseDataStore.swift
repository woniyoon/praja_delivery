//
//  UserFirebaseDataStore.swift
//  delivery
//
//  Created by Sara N on 2018-03-12.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import Firebase

//class UserFirebaseDataStore: UserDataStoreProtocol {
//    let db = Firestore.firestore()
//
//    let name = "Raana"
//    let age = 64
//    let dict = [String: Any] = ["name" : name,
//                                "age" : age]
//    func fetchProductDetail(_ id: String) -> ProductEntity {
//        let productRef = db.collection("Users").addDocument(data: dict)
//
//    }
//}
class UserFirebaseDataStore: UserDataStoreProtocol {
    let db = Firestore.firestore()
    
    func fetchUser(_ id: String) ->UserEntity {
        
        return UserEntity(firstName:"sara")
        
    }
}

