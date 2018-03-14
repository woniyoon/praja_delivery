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

        container.register(AccountViewController.self) { _ in
            let dataStore  = container.resolve(AccountDataStoreProtocol.self)
            let repository = container.resolve(AccountRepositoryProtocol.self, argument: dataStore!)
            let translator = container.resolve(AccountTranslator.self)
            let usecase    = container.resolve(AccountUseCaseProtocol.self, arguments: repository!, translator!)
            let viewModel  = container.resolve(AccountViewModel.self, argument: usecase!)
            let vc         = AccountViewController.createInstance(viewModel: viewModel!)
        }
        
        container.register(HomeViewController.self) { _ in
            let dataStore = container.resolve(HomeDataStoreProtocol.self)
            let repository = container.resolve(HomeRepositoryProtocol.self, argument: dataStore!)
            let translator = container.resolve(HomeTranslator.self)
            let usecase = container.resolve(HomeUseCaseProtocol.self, arguments: repository!, translator!)
            let viewModel = container.resolve(HomeViewModel.self, argument: usecase!)
            let vc = HomeViewController.createInstance(viewModel: viewModel!)
            return vc!
        }
    }
}
