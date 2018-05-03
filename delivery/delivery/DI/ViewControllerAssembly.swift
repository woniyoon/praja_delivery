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
//        container.register(AccountViewController.self) { _ in
//            let dataStore  = container.resolve(AccountDataStoreProtocol.self)
//            let repository = container.resolve(AccountRepositoryProtocol.self, argument: dataStore!)
//            let translator = container.resolve(AccountTranslator.self)
//            let usecase    = container.resolve(AccountUseCaseProtocol.self, arguments: repository!, translator!)
//            let viewModel  = container.resolve(AccountViewModel.self, argument: usecase!)
//            let vc         = AccountViewController.createInstance(viewModel: viewModel!)
//             return vc!
//        }
        container.register(AccountViewController.self) { _ in
            let dataStore  = container.resolve(UserDataStoreProtocol.self)
            let repository = container.resolve(UserRepositoryProtocol.self, argument: dataStore!)
            let translator = container.resolve(UserTranslator.self)
            let usecase    = container.resolve(UserUseCaseProtocol.self, arguments: repository!, translator!)
            let viewModel  = container.resolve(AccountViewModel.self, argument: usecase!)
            let vc         = AccountViewController.createInstance(viewModel: viewModel!)
             return vc!
        }
        
        container.register(HomeViewController.self) { _ in
            print("jaewoooooooon")
            let dataStore = container.resolve(HomeDataStoreProtocol.self)
            let repository = container.resolve(HomeRepositoryProtocol.self, argument: dataStore!)
            let translator = container.resolve(HomeTranslator.self)
            let usecase = container.resolve(HomeUseCaseProtocol.self, arguments: repository!, translator!)
            let viewModel = container.resolve(HomeViewModel.self, argument: usecase!)
            let vc = HomeViewController.createInstance(viewModel: viewModel!)
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
        
        container.register(ReviewListViewController.self) { _ in
            let dataStore  = container.resolve(ReviewListDataStoreProtocol.self)
            let repository = container.resolve(ReviewListRepositoryProtocol.self, argument: dataStore!)
            let translator = container.resolve(ReviewListTranslator.self)
            let usecase    = container.resolve(ReviewListUseCaseProtocol.self, arguments: repository!, translator!)
            let viewModel  = container.resolve(ReviewListViewModel.self, argument: usecase!)
            let vc         = ReviewListViewController.createInstance(viewModel: viewModel!)
            return vc!
        }
        
        container.register(CheckoutViewController.self) { _ in
            let dataStore  = container.resolve(UserDataStoreProtocol.self)
            let repository = container.resolve(UserRepositoryProtocol.self, argument: dataStore!)
            let translator = container.resolve(UserTranslator.self)
            let usecase    = container.resolve(CheckoutUseCaseProtocol.self, arguments: repository!, translator!)
            let viewModel  = container.resolve(CheckoutViewModel.self, argument: usecase!)
            let vc         = CheckoutViewController.createInstance(viewModel: viewModel!)
            return vc!
        }
        
        container.register(AddressEditViewController.self) { _ in
            let dataStore  = container.resolve(UserDataStoreProtocol.self)
            let repository = container.resolve(UserRepositoryProtocol.self, argument: dataStore!)
            let translator = container.resolve(UserTranslator.self)
            let usecase    = container.resolve(AddressEditUseCaseProtocol.self, arguments: repository!, translator!)
            let viewModel  = container.resolve(AddressEditViewModel.self, argument: usecase!)
            let vc         = AddressEditViewController.createInstance(viewModel: viewModel!)
            return vc!
        }
        container.register(AddressListViewController.self) { _ in
            let dataStore  = container.resolve(UserDataStoreProtocol.self)
            let repository = container.resolve(UserRepositoryProtocol.self, argument: dataStore!)
            let translator = container.resolve(UserTranslator.self)
            let usecase    = container.resolve(AddressListUseCaseProtocol.self, arguments: repository!, translator!)
            let viewModel  = container.resolve(AddressListViewModel.self, argument: usecase!)
            let vc         = AddressListViewController.createInstance(viewModel: viewModel!)
            return vc!
        }
        container.register(UserInfoEditViewController.self) { _ in
            let dataStore  = container.resolve(UserDataStoreProtocol.self)
            let repository = container.resolve(UserRepositoryProtocol.self, argument: dataStore!)
            let translator = container.resolve(UserTranslator.self)
            let usecase    = container.resolve(UserInfoEditUseCaseProtocol.self, arguments: repository!, translator!)
            let viewModel  = container.resolve(UserInfoEditViewModel.self, argument: usecase!)
            let vc         = UserInfoEditViewController.createInstance(viewModel: viewModel!)
            return vc!
        }
    }
}
