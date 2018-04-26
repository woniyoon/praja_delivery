//
//  UserFirebaseDataStore.swift
//  delivery
//
//  Created by Diego H. Vanni on 2018-03-12.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import Firebase
import RxSwift
import RxCocoa

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
    }
    
    
    func updateAddress(address: AddressEntity) {
        db.collection("users").document("Ljk5vGaGSMkYzviKx68B").updateData([
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
        print("updateUser in FirebaseDatastore!")
        return Completable.create { observer in
            let dict = user.dictionary
            print(dict)
            self.db.collection("users").document("hIgQB6Fu5uTgQP1uCUcT").setData(user.dictionary) { err in
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
}

