//
//  AccountFirebaseDataStore.swift
//  delivery
//
//  Created by Diego H. Vanni on 2018-03-12.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import Firebase
import RxSwift
import RxCocoa

class AccountFirebaseDataStore: AccountDataStoreProtocol {
    let db = Firestore.firestore()

    func fetchAccount(_ id: String) -> Single<AccountEntity> {

        print("SHIT HERE!")
        
        return Single<AccountEntity>.create { observer -> Disposable in
            self.db.collection("users").whereField("email", isEqualTo: id)
                  .getDocuments{ (querySnapshot, err) in
                    if let err = err {
                        print(err)
                    } else {
                        if let qs = querySnapshot {
                            let test = qs.documents
                            for t in test {
                            print(t.data())
                            }
                        }
                    }
            
            
//                .document(id)
//                .getDocument { (document, error) in
//                    if let error = error {
//                        observer(.error(NomnomError.network(code: "", message: ErrorMsg.tryAgain, log: error.localizedDescription)))
//                        return
//                    }
//                    guard let product = ProductEntity(dictionary: (document?.data())!) else {
//                        observer(.error(NomnomError.alert(message: "Parse Failure")))
//                        return
//                    }
//                    observer(.success(product))
//            }
//            return Disposables.create()
        }
            return Disposables.create()
    }
}
}

