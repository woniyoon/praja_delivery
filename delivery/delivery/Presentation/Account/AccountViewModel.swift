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

class AccountViewModel: BaseViewModel {
    
    var firstName = BehaviorRelay(value: "")
    var lastName = BehaviorRelay(value: "")
    var fullName = BehaviorRelay(value: "")
    var dateOfBirth = BehaviorRelay(value: "")
    var mobileNumber = BehaviorRelay(value: "")
    var email = BehaviorRelay(value: "")
    var totalPoint = BehaviorRelay(value: "")
    var address = BehaviorRelay<[Address]>(value: [])
    var payment = BehaviorRelay<[Payment]>(value: [])
    
    private let useCase: UserUseCaseProtocol
    private let disposeBag: DisposeBag = DisposeBag()
    
    init(useCase: UserUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func fetchAccount(_ id: String) {
        useCase.fetchAccount(id)
            .subscribe(
                onSuccess: { model in
                    
                    var date = Date()
                    var formattedDate = ""
                    date = model.dateOfBirth!
                    formattedDate = date.toString(dateFormat: "MM-dd-yyyy")
                    
                    self.firstName.accept("\(model.firstName)")
                    self.lastName.accept("\(model.lastName)")
                    self.fullName.accept("\(model.fullName)")
                    self.dateOfBirth.accept("\(formattedDate)")
                    self.mobileNumber.accept("\(model.mobileNumber)")
                    self.email.accept("\(model.email)")
                    self.totalPoint.accept("NumNum Points: \(model.totalPoint)")
                    self.address.accept(model.address)
                    self.payment.accept(model.payment)
            },
                onError: { error in print(error) }
            )
            .disposed(by: disposeBag)
    }
}
