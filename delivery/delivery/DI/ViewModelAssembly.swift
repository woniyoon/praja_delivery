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
        
        container.register(ProductListViewModel.self) { (_, useCase: ProductListUseCaseProtocol) in
            ProductListViewModel(useCase: useCase)
        }
    }
}
