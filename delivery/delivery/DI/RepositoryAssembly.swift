//
//  DataManagerAssembly.swift
//  delivery
//
//  Created by Kento Uchida on 2018/03/09.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Swinject

final class RepositoryAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ProductDetailRepositoryProtocol.self) { (_, dataStore: ProductDetailDataStoreProtocol) in
            ProductDetailRepository(dataStore: dataStore)
        }
        container.register(OrderRepositoryProtocol.self) { (_, dataStore: OrderDataStoreProtocol) in
            OrderRepository(dataStore: dataStore)
        }
//        container.register(AccountRepositoryProtocol.self) { (_, dataStore: AccountDataStoreProtocol) in
//            AccountRepository(dataStore: dataStore)
//        }
        container.register(HomeRepositoryProtocol.self){ (_, dataStore: HomeDataStoreProtocol) in
            HomeRepository(dataStore: dataStore)
        }
        container.register(UserRepositoryProtocol.self) { (_, dataStore: UserDataStoreProtocol) in
            UserRepository(dataStore: dataStore)
        }
        container.register(ProductListRepositoryProtocol.self) { (_, dataStore: ProductListDataStoreProtocol) in
            ProductListRepository(dataStore: dataStore)
        }
        container.register(ReviewListRepositoryProtocol.self) { (_, dataStore: ReviewListDataStoreProtocol) in
            ReviewListRepository(dataStore: dataStore)
        }
    }
}
