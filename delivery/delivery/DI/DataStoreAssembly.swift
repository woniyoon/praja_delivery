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
        container.register(AccountDataStoreProtocol.self) { _ in
            AccountFirebaseDataStore()
        }
        container.register(HomeDataStoreProtocol.self) { _
            in
            HomeFirebaseDataStore()
        }
        container.register(UserDataStoreProtocol.self) { _ in
            UserFirebaseDataStore()
        }
    }
}
