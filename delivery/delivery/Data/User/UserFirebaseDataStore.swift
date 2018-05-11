//
//  UserFirebaseDataStore.swift
//  delivery
//
//  Created by Sara N on 2018-03-12.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import Firebase
import RxSwift

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
    
    func fetchUser(_ id: String) -> Single<UserEntity> {
        
            return Single<UserEntity>.create { observer -> Disposable in
                self.db.collection("users")
                    .document("Ljk5vGaGSMkYzviKx68B")
                    .getDocument() { (document, error) in
                        if let error = error {
                            observer(.error(error))
                            return
                        }
                        guard let user = UserEntity(dictionary: (document?.data())!) else {
                            observer(.error(error!))
                            return
                        }
                        observer(.success(user))
                }
                return Disposables.create()
        }
    }
}

