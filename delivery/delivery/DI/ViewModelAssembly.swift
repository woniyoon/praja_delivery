//
//  ViewModelAssembly.swift
//  delivery
//
//  Created by Kento Uchida on 2018/03/09.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Swinject

final class ViewModelAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ProductDetailViewModel.self) { (_, useCase: ProductDetailUseCaseProtocol) in
            ProductDetailViewModel(useCase: useCase)
        }
        container.register(AccountViewModel.self) { (_, useCase: AccountUseCaseProtocol) in
            AccountViewModel(useCase: useCase)
        }
        
        container.register(HomeViewModel.self) { (_, useCase: HomeUseCaseProtocol) in
            HomeViewModel(useCase: useCase)
           }
            container.register(UserViewModel.self) { (_, useCase: UserUseCaseProtocol) in
                UserViewModel(useCase: useCase)
        }
    }
}
