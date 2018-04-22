//
//  AddressListViewModel.swift
//  delivery
//
//  Created by Jaewon Yoon on 2018-04-20.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class AddressListViewModel: BaseViewModel {
    
    var addressList = BehaviorRelay<[Address]>(value: [])

    private let useCase: AddressListUseCaseProtocol
    private let disposeBag: DisposeBag = DisposeBag()
    
    init(useCase: AddressListUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func fetchAddressList() {
        let test: [Address] = [Address(receiver: "Jaewon Yoon", address1: "1202", address2: "1050 Burrard St", city: "Vancouver", province: "BC", postalCode: "V6Z 2S3", country: "Canada", isDefault: true),
                               Address(receiver: "Jiyoung Youn", address1: "1050", address2: "738 Seymour St", city: "Vancouver", province: "BC", postalCode: "V6Z 6F2", country: "Canada", isDefault: false)]
        addressList.accept(test)
    }
}

