//
//  TranslatorAssembly.swift
//  delivery
//
//  Created by Kento Uchida on 2018/03/09.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Swinject

final class TranslatorAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ProductDetailTranslator.self) { _ in
            ProductDetailTranslator()
        }
        
        container.register(HomeTranslator.self) { _ in
            HomeTranslator()
        }
    }
}
