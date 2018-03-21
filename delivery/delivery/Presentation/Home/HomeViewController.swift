//
//  HomeViewController.swift
//  delivery
//
//  Created by Jaewon Yoon on 2018-03-12.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import Firebase

class HomeViewController: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var originalPrice: UILabel!
    
    
    private var viewModel: HomeViewModel!
    private let disposeBag: DisposeBag = DisposeBag()
    
    static func createInstance(viewModel: HomeViewModel) -> HomeViewController? {
        let instance = UIViewController.initialViewControllerFromStoryBoard(HomeViewController.self)
        instance?.viewModel = viewModel
        return instance
    }
    
    @IBAction func dbTest(_ sender: Any) {
        
//        let orderBuilder = OrderBuilder(userId: "userId", dateOfPurchase: Date(), deliveryFee: 5.0, totalPrice: 25.0).setRemark(remark: "fragile!")
//
//        let test = Order(builder: orderBuilder)
//
//        if let t = test {
//            print(t.remark)
//        }
    }
    

    
    private func bindView() {
        viewModel.name.asObservable()
            .bind(to: name.rx.text)
            .disposed(by: disposeBag)
        viewModel.price.asObservable()
            .bind(to: price.rx.text)
            .disposed(by: disposeBag)
        viewModel.originalPrice.asObservable()
            .bind(to: originalPrice.rx.text)
            .disposed(by: disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
        viewModel.fetchProducts()
    }

}
