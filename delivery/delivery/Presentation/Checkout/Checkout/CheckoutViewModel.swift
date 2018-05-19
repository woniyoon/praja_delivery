//
//  CheckoutViewModel.swift
//  delivery
//
//  Created by Jaewon Yoon on 2018-04-04.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class CheckoutViewModel: BaseViewModel {
    
    public var dataForSection = BehaviorRelay<[SectionModel<String, User>]>(value: [])
    var user = BehaviorRelay<[User]>(value: [])
//    var firstName = BehaviorRelay(value: "")
//    var lastName = BehaviorRelay(value: "")
//    var fullName = BehaviorRelay(value: "")
//    var dateOfBirth = BehaviorRelay(value: Date())
//    var mobileNumber = BehaviorRelay(value: "")
//    var email = BehaviorRelay(value: "")
//    var totalPoint = BehaviorRelay(value: "")
//    var address = BehaviorRelay<[Address]>(value: [])
//    var payment = BehaviorRelay<[Payment]>(value: [])
//    var paymentTest: [Payment] = []
    
    private let disposeBag: DisposeBag = DisposeBag()
    private let useCase: UserUseCaseProtocol
    
    // MARK: - Init
    
    init(useCase: UserUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func updateUser() {
        useCase.updateUser(user: self.user.value.first!)
    }
    
    func fetchUser() {
        useCase.fetchUser()
            .subscribe(onSuccess: { (user) in

                self.dataForSection.accept([SectionModel(model: "User Information", items: [user]),
                                  SectionModel(model: "Shipping To", items: [user]),
                                  SectionModel(model: "Payment", items: [user])
                    ])
                
                self.user.accept([user])
            }, onError: { (err) in
                print(err)
            }).disposed(by: disposeBag)
    }
}
