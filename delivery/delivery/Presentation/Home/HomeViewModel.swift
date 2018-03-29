//
//  HomeViewModel.swift
//  delivery
//
//  Created by Jaewon Yoon on 2018-03-12.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel: BaseViewModel {
    
    var arr = BehaviorRelay<[Product]>(value: [])

    private let disposeBag: DisposeBag = DisposeBag()
    private let useCase: HomeUseCaseProtocol

    init(useCase: HomeUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func fetchArrayOfProduct() {
        useCase.fetchArrayOfProduct()
                    .subscribe(
                        onSuccess: { model in
                            self.arr.accept(model)
                           
                    },
                        onError: { error in print(error) }
                    )
                    .disposed(by: disposeBag)
    }
}
