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

    func fetchUser(_ id: String) -> Single<UserEntity> {
        
        return Single<UserEntity>.create { observer -> Disposable in
            self.db.collection("users").whereField("email", isEqualTo: id)
                  .getDocuments{ (querySnapshot, error) in
                    if let error = error {
                        observer(.error(NomnomError.network(code: "", message: ErrorMsg.tryAgain, log:error.localizedDescription)))
                        return
                    }
                        guard let account = UserEntity(dictionary: (querySnapshot?.documents[0].data())!) else {
                            observer(.error(NomnomError.alert(message: "Parse Failure")))
                            return
                        }
                        observer(.success(account))
        }
            return Disposables.create()
    }
}
}

