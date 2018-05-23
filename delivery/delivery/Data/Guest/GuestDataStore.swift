//
//  GuestDataStore.swift
//  delivery
//
//  Created by Jaewon Yoon on 2018-05-20.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import RxSwift
import Realm
import RealmSwift
import RxCocoa
import RxRealm

class GuestDataStore: GuestDataStoreProtocol {
    func saveGuestInfo(userEntity: UserEntity) -> Completable {
        let guestToSave = self.mapToGuestInfoEntity(userEntity: userEntity)
        
        let realm = RealmManager.sharedInstance
        guestToSave.id = realm.getNewId(type: GuestInfoEntity.self)!
        realm.addData(object: guestToSave)
        print("realm!")
        return Completable.create(subscribe: { (observer) -> Disposable in
            if realm.getData(type: GuestInfoEntity.self)?.count != 0 {
                    observer(.completed)
                } else {
                    observer(.error(NomnomError.noData(message: "Failed to write a data")))
                }
            return Disposables.create()
        })
    }
    
    func fetchGuest() -> Single<UserEntity> {
        print("GuestDataStore before return")
        return Single<UserEntity>
         .zip(fetchGuestInfo(), fetchGuestAddress()) { (info, address) in
            print("GuestDataStore")
            print(info)
            print(address)
            return UserEntity(firstName: info.firstName,
                              lastName: info.lastName,
                              mobileNumber: info.mobileNumber,
                              dateOfBirth: nil,
                              isMember: false,
                              totalPoint: 0,
                              email: info.email,
                              address: self.mapToAddress(address),
                              payment: nil,
                              coupon: nil)
        }
        
    }
    
    func fetchGuestInfo() -> Single<GuestInfoEntity> {
        let realm = RealmManager.sharedInstance
        
        return Single<GuestInfoEntity>.create { observer -> Disposable in
            //            if let data = realm.getData(type: GuestInfoEntity.self) {
            if realm.getData(type: GuestInfoEntity.self)?.count != 0 {
                let data = realm.getData(type: GuestInfoEntity.self)
                print(data)
                
                let guestInfoEntity = data![data!.endIndex-1] as! GuestInfoEntity
                observer(.success(guestInfoEntity))
            } else {
                observer(.error(NomnomError.noData(message: "Failed to fetch the data from Realm")))
            }
            
            return Disposables.create()
        }
    }
    
    func fetchGuestAddress() -> Single<GuestAddressEntity?> {
        let realm = RealmManager.sharedInstance
        
        return Single<GuestAddressEntity?>.create { observer -> Disposable in
            //            if let data = realm.getData(type: GuestInfoEntity.self) {
            let dispose = Disposables.create()
            
            guard let data = realm.getData(type: GuestAddressEntity.self) else {
                observer(.error(NomnomError.noData(message: "Failed to fetch the data from Realm")))
                return dispose
            }
            
            if data.count != 0 {
                let data = realm.getData(type: GuestAddressEntity.self)
                
                let guestInfoEntity = data![data!.endIndex-1] as! GuestAddressEntity
                observer(.success(guestInfoEntity))
            } else {
                observer(.success(nil))
            }
            
            return dispose
        }
    }
    
    private func mapToAddress(_ guestAddress: GuestAddressEntity?) -> [AddressEntity]? {
        // TODO: JAEWON NO SHIGOTO
        return nil
    }
    
    private func mapToGuestInfoEntity(userEntity: UserEntity) -> GuestInfoEntity {
        let guestInfoEntity = GuestInfoEntity()
        guestInfoEntity.firstName = userEntity.firstName
        guestInfoEntity.lastName = userEntity.lastName
        guestInfoEntity.mobileNumber = userEntity.mobileNumber
        guestInfoEntity.email = userEntity.email
        return guestInfoEntity
    }
}
