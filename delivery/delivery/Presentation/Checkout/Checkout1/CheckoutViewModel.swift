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
    
    public var user = BehaviorRelay<[User]>(value: [User(firstName: "Jaewon", lastName: "Yoon", mobileNumber: "7788702140", dateOfBirth: Date(), email: "woniyoon@gmail.com", totalPoint: 0, address: [Address(receiver: "Jaewon", address1: "1202", address2: "1050 Burrard st", city: "Vancouver", province: "BC", postalCode: "V6Z 2S3", country: "Canada")], payment: [Payment(cardNumber: "2137 1231 4942 1232", holderName: "Jaewon Yoon", expiryDate: Date())], coupon: nil)])

    
    private let disposeBag: DisposeBag = DisposeBag()
    private let useCase: CheckoutUseCaseProtocol
    
    // MARK: - Init
    
    init(useCase: CheckoutUseCaseProtocol) {
        self.useCase = useCase
    }
    
    
}
