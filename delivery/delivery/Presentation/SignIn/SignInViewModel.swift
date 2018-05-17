//
//  SignInViewModel.swift
//  delivery
//
//  Created by Jaewon Yoon on 2018-05-16.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SignInViewModel: BaseViewModel {
    
    private let disposeBag: DisposeBag = DisposeBag()
    private let useCase: UserUseCaseProtocol
    
    // MARK: - Init
    
    init(useCase: UserUseCaseProtocol) {
        self.useCase = useCase
    }
    
}
