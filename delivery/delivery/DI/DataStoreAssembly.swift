//
//  DataStoreAssembly.swift
//  delivery
//
//  Created by Kento Uchida on 2018/03/09.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Swinject

final class DataStoreAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ProductDetailDataStoreProtocol.self) { _ in
            ProductDetailFirebaseDataStore()
        }
        container.register(OrderDataStoreProtocol.self) { _ in
            OrderFirebaseDataStore()
        }
        container.register(UserDataStoreProtocol.self) { _ in
            UserFirebaseDataStore()
        }
        container.register(HomeDataStoreProtocol.self) { _ in
            HomeFirebaseDataStore()
        }
        container.register(ProductListDataStoreProtocol.self) { _ in
            ProductListFirebaseDataStore()
        }
        container.register(ReviewListDataStoreProtocol.self) { _ in
            ReviewListFirebaseDataStore()
        }
    }
}
