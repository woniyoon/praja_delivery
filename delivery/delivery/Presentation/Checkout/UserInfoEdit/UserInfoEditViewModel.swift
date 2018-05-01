//
//  UserInfoEditViewModel.swift
//  delivery
//
//  Created by Jaewon Yoon on 2018-04-26.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class UserInfoEditViewModel: BaseViewModel {

    var firstName = BehaviorRelay(value: "")
    var lastName = BehaviorRelay(value: "")
    var email = BehaviorRelay(value: "")
    var phoneNumber = BehaviorRelay(value: "")
    var user = BehaviorRelay<[User]>(value: [])
    
    private let useCase: UserInfoEditUseCaseProtocol
    private let disposeBag: DisposeBag = DisposeBag()
    
    init(useCase: UserInfoEditUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func fetchUser() {
        useCase.fetchUser().subscribe(onSuccess: { (user) in
            self.firstName.accept(user.firstName)
            self.lastName.accept(user.lastName)
            self.email.accept(user.email)
            self.phoneNumber.accept(user.mobileNumber)
            let arr: [User] = [user]
            self.user.accept(arr)
            print(user.firstName)
        }) { (err) in
            print(err)
        }.disposed(by: disposeBag)
    }
    
    func updateUser() -> Completable {
        if user.value.count > 0 {
            let updatedUser = User(firstName: firstName.value, lastName: lastName.value, dateOfBirth: user.value.first?.dateOfBirth, mobileNumber: phoneNumber.value, email: email.value, totalPoint: (user.value.first?.totalPoint)!, address: user.value.first?.address, payment: user.value.first?.payment, coupon: user.value.first?.coupon)
            return useCase.updateUser(user: updatedUser)
        } else {
            let updatedUser = User(firstName: firstName.value, lastName: lastName.value, dateOfBirth: nil, mobileNumber: phoneNumber.value, email: email.value, totalPoint: 0, address: nil, payment: nil, coupon: nil)
            return useCase.updateUser(user: updatedUser)
        }
    }
}
