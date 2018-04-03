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
    func fetchTopSales() -> Single<[ProductEntity]>
    func fetchProductYouMayLike() -> Single<[ProductEntity]>
    func fetchNewProducts() -> Single<[ProductEntity]>
}
