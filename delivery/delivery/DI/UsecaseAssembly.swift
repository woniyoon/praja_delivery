//
//  UsecaseAssembly.swift
//  delivery
//
//  Created by Kento Uchida on 2018/03/09.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Swinject

final class UsecaseAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ProductDetailUseCaseProtocol.self) { (_, repository: ProductDetailRepositoryProtocol, translator: ProductDetailTranslator) in
            ProductDetailUseCase(repository: repository, translator: translator)
        }
        container.register(OrderUseCaseProtocol.self) { (_, repository: OrderRepositoryProtocol, translator: OrderTranslator) in
            OrderUseCase(repository: repository, translator: translator)
        }
    }
}
