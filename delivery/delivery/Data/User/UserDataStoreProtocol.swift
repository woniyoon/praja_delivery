//
//  UserDataStoreProtocol.swift
//  delivery
//
//  Created by Sara N on 2018-03-12.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import RxSwift

protocol UserDataStoreProtocol {
    func fetchUser(_ id: String) -> Single<UserEntity>
}
