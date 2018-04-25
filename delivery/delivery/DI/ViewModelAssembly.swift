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
        container.register(OrderViewModel.self) { (_, useCase: OrderUseCaseProtocol) in
            OrderViewModel(useCase: useCase)
        }
        container.register(AccountViewModel.self) { (_, useCase: UserUseCaseProtocol) in
            AccountViewModel(useCase: useCase)
        }
        container.register(HomeViewModel.self) { (_, useCase: HomeUseCaseProtocol) in
            HomeViewModel(useCase: useCase)
        }
        container.register(ProductListViewModel.self) { (_, useCase: ProductListUseCaseProtocol) in
            ProductListViewModel(useCase: useCase)
        }
        container.register(ReviewListViewModel.self) { (_, useCase: ReviewListUseCaseProtocol) in
            ReviewListViewModel(useCase: useCase)
        }
        container.register(CheckoutViewModel.self) { (_, useCase: CheckoutUseCaseProtocol) in
            CheckoutViewModel(useCase: useCase)
        }
        container.register(AddressEditViewModel.self) { (_, useCase: AddressEditUseCaseProtocol) in
            AddressEditViewModel(useCase: useCase)
        }
        container.register(AddressListViewModel.self) { (_, useCase: AddressListUseCaseProtocol) in
            AddressListViewModel(useCase: useCase)
        }
    }
}
