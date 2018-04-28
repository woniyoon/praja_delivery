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
        useCase.fetchAddressList()
            .subscribe(onSuccess: { (addressList) in
                self.addressList.accept(addressList)
                
                addressList.forEach({ (t) in
                    print(t.isDefault)
                })
            }, onError: { (err) in
                print(err)
            }).disposed(by: disposeBag)
    }
    
    func updateAddressList() -> Completable {
        print(self.addressList.value[2].isDefault)
       return useCase.updateAddressList(addressList: self.addressList.value)
    }
}

