//
//  ShoppingCartViewModel.swift
//  delivery
//
//  Created by Bacelar on 2018-04-12.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift
import RxCocoa

class ShoppingCartViewModel: BaseViewModel {
    
    private var useCase: ShoppingCartUseCaseProtocol
    
    public var productsList = BehaviorRelay<[ShoppingCart]>(value: [])
    private let disposeBag: DisposeBag = DisposeBag()
    
    init(useCase: ShoppingCartUseCaseProtocol) {
        self.useCase = useCase
    }
    
    func fetchShoppingCartList(){
        
        useCase.fetchShoppingCart()
//            .subscribe(
//                onSuccess: { (product) in
//                    self.productsList.accept(product)
//            }, onError: { (error) in
//                print(error.localizedDescription)}
//            ) .disposed(by: disposeBag)
    }
        
}
