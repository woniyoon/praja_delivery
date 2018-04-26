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

    private let useCase: UserInfoEditUseCaseProtocol
    private let disposeBag: DisposeBag = DisposeBag()
    
    init(useCase: UserInfoEditUseCaseProtocol) {
        self.useCase = useCase
    }
}
