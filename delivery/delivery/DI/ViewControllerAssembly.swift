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
        
        container.register(OrderViewController.self) { _ in
            let dataStore  = container.resolve(OrderDataStoreProtocol.self)
            let repository = container.resolve(OrderRepositoryProtocol.self, argument: dataStore!)
            let translator = container.resolve(OrderTranslator.self)
            let usecase    = container.resolve(OrderUseCaseProtocol.self, arguments: repository!, translator!)
            let viewModel  = container.resolve(OrderViewModel.self, argument: usecase!)
            let vc         = OrderViewController.createInstance(viewModel: viewModel!)
            return vc!
        }
    }
}
