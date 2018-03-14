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
        
        container.register(HomeRepositoryProtocol.self)
        { (_, dataStore: HomeDataStoreProtocol) in
            HomeRepository(dataStore: dataStore)
        }
    }
}
