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

class UserFirebaseDataStore: UserDataStoreProtocol {
    
    let db = Firestore.firestore()
    
    func fetchUser() -> Single<UserEntity> {
        
//        let user = Auth.auth().currentUser
//        if let user = user {
            return Single<UserEntity>.create { observer -> Disposable in
                self.db.collection("users")
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
//        }
//        else {
//            AlertError.init(title: "Reminder", message: "Please Sign In First")
//        }
    }
    
    func updateAddress(address: AddressEntity) {

    }
    
    func updateUser(user: UserEntity) {
        
    }
}

