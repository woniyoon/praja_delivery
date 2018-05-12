//
//  AccountEditViewModel.swift
//  delivery
//
//  Created by Jaewon Yoon on 2018-05-10.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class AccountEditViewModel: BaseViewModel {
    var firstName = BehaviorRelay(value: "")
    var lastName = BehaviorRelay(value: "")
    var phoneNumber = BehaviorRelay(value: "")
    var email = BehaviorRelay(value: "")
    var birthDate = BehaviorRelay(value: "")

    private let useCase: UserUseCaseProtocol
    private let disposeBag: DisposeBag = DisposeBag()
        
    init(useCase: UserUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func fetchUser() {
        useCase.fetchUser().subscribe(onSuccess: { (user) in
            self.firstName.accept(user.firstName)
            self.lastName.accept(user.lastName)
            self.phoneNumber.accept(user.mobileNumber)
            self.email.accept(user.email)
            
            if let birthDate = user.dateOfBirth {
                let birthDateString = DateFormatter.birthDateInFormat(birthDate: birthDate)
                self.birthDate.accept(birthDateString)
            }
        }, onError: { (err) in
            print(err)
        })
    }
    
    func updateUser() {
        
    }
    
    func changePassword() {
        
    }
}
