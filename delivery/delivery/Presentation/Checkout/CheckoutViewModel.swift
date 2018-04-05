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
    
    private let disposeBag: DisposeBag = DisposeBag()
    private let useCase: CheckoutUseCaseProtocol
    
    // MARK: - Init
    
    init(useCase: CheckoutUseCaseProtocol) {
        self.useCase = useCase
    }
}
