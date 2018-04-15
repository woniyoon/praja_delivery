//
//  UsersViewModel.swift
//  delivery
//
//  Created by Sara N on 2018-03-12.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class UserViewModel{
 
    var firstName = BehaviorRelay(value: "")
    var lastName = BehaviorRelay(value: "")
    var mobileNumber = BehaviorRelay(value: "")
    var dateOfBirth = BehaviorRelay(value: "")
    var hasAccount = BehaviorRelay(value: "")
   // var account = BehaviorRelay(value: "")
    
    private let disposeBag: DisposeBag = DisposeBag()

    private let useCase: UserUseCaseProtocol
    
    init(useCase: UserUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func fetchUser() {
        useCase.fetchUser()
            .subscribe(
                onSuccess: { model in
                    self.firstName.accept("$\(model.firstName)")
                    self.lastName.accept("$\(model.lastName)")
                    self.mobileNumber.accept("$\(model.mobileNumber)")
                    self.dateOfBirth.accept("$\(model.dateOfBirth)")
//                    self.hasAccount.accept("$\(model.hasAccount)")
            },
                onError: { error in
                    print(error.localizedDescription) }
            )
            .disposed(by: disposeBag)
    }
}
