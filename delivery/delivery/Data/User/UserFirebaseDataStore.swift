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
    
    // TODO: change the documentID (= userID)
    
    func fetchUser() -> Single<UserEntity> {
        //        let user = Auth.auth().currentUser
        //        if let user = user {
        return Single<UserEntity>.create { observer -> Disposable in
            self.db.collection(USER_COLLECTION)
                .document("72tKB5nG76CR4dVYW5AM")
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
    
    
    func updateAddress(address: AddressEntity) {
        db.collection(USER_COLLECTION).document("72tKB5nG76CR4dVYW5AM").updateData([
            "address": address
            ])
        { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    func updateUser(user: UserEntity) -> Completable {
        return Completable.create { observer in
            let dict = user.dictionary
            self.db.collection(USER_COLLECTION).document("72tKB5nG76CR4dVYW5AM").setData(user.dictionary) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                    observer(.error(NomnomError.alert(message: "Failed for some reasons!\n\(err.localizedDescription)")))
                } else {
                    print("Document successfully written!")
                    observer(.completed)
                }
            }
            return Disposables.create()
        }
    }
    
//    func updatePassword() {
//        Auth.auth().currentUser?.updatePassword(to: <#T##String#>, completion: <#T##UserProfileChangeCallback?##UserProfileChangeCallback?##(Error?) -> Void#>)
//    }
}

