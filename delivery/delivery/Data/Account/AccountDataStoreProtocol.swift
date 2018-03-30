//
//  AccountDataStoreProtocol.swift
//  delivery
//
//  Created by Diego H. Vanni on 2018-03-12.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol AccountDataStoreProtocol {
    func fetchAccount(_ id: String) -> Single<AccountEntity>
}

