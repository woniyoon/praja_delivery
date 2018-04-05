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
        
        return Single<AccountEntity>.create { observer -> Disposable in
            self.db.collection("users").whereField("email", isEqualTo: id)
                  .getDocuments{ (querySnapshot, error) in
                    if let error = error {
                        observer(.error(NomnomError.network(code: "", message: ErrorMsg.tryAgain, log:error.localizedDescription)))
                        return
                    }
                    print(querySnapshot?.documents[0].data() as Any) //DEVELOPMENT HELP - PRINT SEARCH TO TERMINAL!!
                        guard let account = AccountEntity(dictionary: (querySnapshot?.documents[0].data())!) else {
                            observer(.error(NomnomError.alert(message: "Parse Failure")))
                            return
                        }
                        observer(.success(account))
        }
            return Disposables.create()
    }
}
}

