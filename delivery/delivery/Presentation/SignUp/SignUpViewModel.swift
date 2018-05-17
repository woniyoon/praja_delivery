//
//  SignUpViewModel.swift
//  delivery
//
//  Created by Kento Uchida on 2018/05/16.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SignUpViewModel: BaseViewModel {
    
    // MARK: - Private Properties
    private let useCase: UserUseCaseProtocol
    private let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - Initializer
    init(useCase: UserUseCaseProtocol) {
        self.useCase = useCase
    }
}
