//
//  UserRepository.swift
//  delivery
//
//  Created by Sara N on 2018-03-12.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import RxSwift

protocol UserRepositoryProtocol {
    func fetchUser(_ id: String) -> Single<UserEntity>
}

class UserRepository: UserRepositoryProtocol {
    
    private let memberDataStore: UserDataStoreProtocol
    
//    init(memberDataStore: UserDataStoreProtocol, guestDataStore: GuestDataStoreProtocol) {
//        self.memberDataStore = memberDataStore
//    }

    init(memberDataStore: UserDataStoreProtocol) {
        self.memberDataStore = memberDataStore
    }
    
    func fetchUser(_ id: String) -> Single<UserEntity> {
//        if memberDataStore.isMember {
//            memberDataStore.fetchUser(id)
//        } else {
////            guestDataStore.die()
//        }
        return memberDataStore.fetchUser(id)
    }
}
