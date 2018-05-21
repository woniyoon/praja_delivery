//
//  OrderReviewViewModel.swift
//  delivery
//
//  Created by Bacelar on 2018-05-21.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift
import RxCocoa


class OrderReviewViewModel: BaseViewModel {
    private var useCaseShoppingCart: ShoppingCartUseCaseProtocol
    private var useCaseUserAccount: UserUseCaseProtocol
    
    var user = BehaviorRelay<[User]>(value: [])
    var fullName = BehaviorRelay(value: "")
    var dateOfBirth = BehaviorRelay(value: "")
    var mobileNumber = BehaviorRelay(value: "")
    var email = BehaviorRelay(value: "")
    
    var receiver = BehaviorRelay(value: "")
    var address = BehaviorRelay(value: "")
    var postalCode = BehaviorRelay(value: "")
    
    var cardholder = BehaviorRelay(value: "")
    var cardNumber = BehaviorRelay(value: "")
    var expiryDate = BehaviorRelay(value: "")
    
    var productsShoppingCart = BehaviorRelay<[ProductShoppingCart]>(value: [])
    var subTotal = BehaviorRelay<String>(value: "0.0")
    var discount = BehaviorRelay<String>(value: "0.0")
    var hsttax = BehaviorRelay<String>(value: "0.0")
    var total = BehaviorRelay<String>(value: "0.0")
    
    private let disposeBag: DisposeBag = DisposeBag()
    
    init(useCaseShoppingCart: ShoppingCartUseCaseProtocol, useCaseUserAccount: UserUseCaseProtocol ) {
        self.useCaseShoppingCart = useCaseShoppingCart
        self.useCaseUserAccount = useCaseUserAccount
    }
    
    func fetchUser() {
        useCaseUserAccount.fetchUser().subscribe(onSuccess: { (user) in
            self.user.accept([user])
            
            self.fullName.accept("\(user.firstName) \(user.lastName)")
            self.email.accept(user.email)
            if let dateOfBirth = user.dateOfBirth {
                let birthDateString = DateFormatter.birthDateInFormat(birthDate: dateOfBirth)
                self.dateOfBirth.accept(birthDateString)
            }
            
            self.mobileNumber.accept(user.mobileNumber)
            
            if let address = user.address {
                let defaultAddress = address.filter({ $0.isDefault })
                
                self.address.accept("\((defaultAddress.first?.address1)!) \((defaultAddress.first?.address2)!)")
                self.receiver.accept((defaultAddress.first?.receiver)!)
                self.postalCode.accept((defaultAddress.first?.postalCode)!)
            }
            
            if let payment = user.payment {
                let defaultPayment = payment.filter({ $0.isDefault })
                
                self.cardholder.accept((defaultPayment.first?.holderName)!)
                self.cardNumber.accept((defaultPayment.first?.cardNumber)!)
                let expiryDateString = DateFormatter.expiryDateInFormat(expiryDate: (defaultPayment.first?.expiryDate)!)
                self.expiryDate.accept(expiryDateString)
            }
        }, onError: { (error) in
            print(error.localizedDescription)}
            ) .disposed(by: disposeBag)
    }
    
    func fetchShoppingCartList(){
        useCaseShoppingCart.fetchShoppingCart()
            .subscribe(
                onSuccess: { (productsList) in
                    
                    self.productsShoppingCart.accept(productsList)
                    
                    self.calculateSubTotal()
                    
            }, onError: { (error) in
                print(error.localizedDescription)}
            ) .disposed(by: disposeBag)
    }
    
    func calculateSubTotal(){
        let shoppingCart = productsShoppingCart.value
        
        var preSubTotal = 0.0
        
        for item in shoppingCart {
            preSubTotal = preSubTotal + item.total
        }
        subTotal.accept("$ \(String(format:"%.2f", preSubTotal))")
        
        discount.accept("$ \(String(format:"%.2f", 0))")
        hsttax.accept("$ \(String(format:"%.2f", 0))")
        
        total.accept("$ \(String(format:"%.2f", preSubTotal))")
    }
}
