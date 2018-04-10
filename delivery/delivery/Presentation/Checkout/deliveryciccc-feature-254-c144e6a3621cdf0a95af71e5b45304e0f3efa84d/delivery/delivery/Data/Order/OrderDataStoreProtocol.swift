//
//  DeliveryDataStoreProtocol.swift
//  delivery
//
//  Created by MATSUHISA MAI on 2018/03/12.
//  Copyright © 2018年 CICCC. All rights reserved.
//

import Foundation
import RxSwift

protocol OrderDataStoreProtocol {
    func fetchOrder(_ id: String) -> Single<OrderEntity> //OrderEntity
}
