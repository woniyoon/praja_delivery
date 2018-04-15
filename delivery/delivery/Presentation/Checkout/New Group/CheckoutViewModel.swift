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

class CheckoutViewModel: BaseViewModel {
    
    public var user = BehaviorRelay<[User]>(value: [])

    var firstName = BehaviorRelay(value: "")
    var lastName = BehaviorRelay(value: "")
    var fullName = BehaviorRelay(value: "")
    var dateOfBirth = BehaviorRelay(value: Date())
    var mobileNumber = BehaviorRelay(value: "")
    var email = BehaviorRelay(value: "")
    var totalPoint = BehaviorRelay(value: "")
    var address = BehaviorRelay<[Address]>(value: [])
    var payment = BehaviorRelay<[Payment]>(value: [])
    
    private let disposeBag: DisposeBag = DisposeBag()
    private let useCase: CheckoutUseCaseProtocol
    
    // MARK: - Init
    
    init(useCase: CheckoutUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func updateUser() {
        useCase.updateUser()
    }
    
    func fetchUser() {
        useCase.fetchUser()
            .subscribe(onSuccess: { (user) in
                self.firstName.accept(user.firstName)
                self.lastName.accept(user.lastName)
                self.mobileNumber.accept(user.mobileNumber)
                self.email.accept(user.email)
                self.address.accept(user.address)
                self.payment.accept(user.payment)
                
                guard let dateOfBirth = user.dateOfBirth else {return}
                self.dateOfBirth.accept(dateOfBirth)
                
                let test = [User(firstName: user.firstName, lastName: user.lastName, mobileNumber: user.mobileNumber, dateOfBirth: user.dateOfBirth, email: user.email, totalPoint: user.totalPoint, address: user.address, payment: user.payment, coupon: user.coupon)]
                
                self.user.accept(test)
                self.address.accept(user.address)
                
            }, onError: { (err) in
                print(err)
            }).disposed(by: disposeBag)
    }
}
