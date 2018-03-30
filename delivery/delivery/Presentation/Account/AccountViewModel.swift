//
//  AccountViewModel.swift
//  delivery
//
//  Created by Diego H. Vanni on 2018-03-13.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class AccountViewModel {
    
    var firstName = BehaviorRelay(value: "")
    var lastName = BehaviorRelay(value: "")
    var dateOfBirth = BehaviorRelay(value: "")
    var mobileNumber = BehaviorRelay(value: "")
    var email = BehaviorRelay(value: "")
    var totalPoint = BehaviorRelay(value: "")
    
    var address = BehaviorRelay<[Address]>(value: [])
    var payment = BehaviorRelay<[Payment]>(value: [])

    
    private let useCase: AccountUseCaseProtocol
    private let disposeBag: DisposeBag = DisposeBag()
    
    init(useCase: AccountUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func fetchAccount(_ id: String) {
        useCase.fetchAccount(id)
            .subscribe(
                onSuccess: { model in
                    self.firstName.accept("$\(model.firstName)")
                    self.lastName.accept("$\(model.lastName)")
                    self.dateOfBirth.accept("$\(model.dateOfBirth)")
                    self.mobileNumber.accept("$\(model.mobileNumber)")
                    self.email.accept("$\(model.email)")
                    self.totalPoint.accept("$\(model.totalPoint)")
                    self.address.accept([Address(receiver: "", address1: "", address2: "", city: "", province: "", postalCode: "", country: "")])
                    self.payment.accept([Payment(cardNumber: "", holderName: "", expiryDate: Date.init())])
            },
                onError: { error in
                    print(error.localizedDescription) }
            )
            .disposed(by: disposeBag)
    }
}
