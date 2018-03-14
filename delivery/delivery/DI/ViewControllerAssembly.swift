//
//  ViewControllerAssembler.swift
//  delivery
//
//  Created by Kento Uchida on 2018/03/09.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Swinject

final class ViewControllerAssembly: Assembly {
    func assemble(container: Container) {
        
        container.register(ProductDetailViewController.self) { _ in
            let dataStore  = container.resolve(ProductDetailDataStoreProtocol.self)
            let repository = container.resolve(ProductDetailRepositoryProtocol.self, argument: dataStore!)
            let translator = container.resolve(ProductDetailTranslator.self)
            let usecase    = container.resolve(ProductDetailUseCaseProtocol.self, arguments: repository!, translator!)
            let viewModel  = container.resolve(ProductDetailViewModel.self, argument: usecase!)
            let vc         = ProductDetailViewController.createInstance(viewModel: viewModel!)
            return vc!
        }
        
        container.register(ProductListViewController.self) { _ in
            let dataStore  = container.resolve(ProductListDataStoreProtocol.self)
            let repository = container.resolve(ProductListRepositoryProtocol.self, argument: dataStore!)
            let translator = container.resolve(ProductListTranslator.self)
            let usecase    = container.resolve(ProductListUseCaseProtocol.self, arguments: repository!, translator!)
            let viewModel  = container.resolve(ProductListViewModel.self, argument: usecase!)
            let vc         = ProductListViewController.createInstance(viewModel: viewModel!)
            return vc!
        }

    }
}
