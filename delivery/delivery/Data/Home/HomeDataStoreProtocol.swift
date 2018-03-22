//
//  HomeDataStoreProtocol.swift
//  delivery
//
//  Created by Jaewon Yoon on 2018-03-12.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import RxSwift

protocol HomeDataStoreProtocol {
    func fetchProducts() -> Single<ProductEntity>
}
