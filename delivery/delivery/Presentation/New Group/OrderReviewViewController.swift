//
//  OrderReviewViewController.swift
//  delivery
//
//  Created by Bacelar on 2018-05-21.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import Firebase

class OrderReviewViewController: BaseViewController {
    
 
    public var viewModel: OrderReviewViewModel!
    
    static func createInstance(viewModel: OrderReviewViewModel) -> OrderReviewViewController? {
        let instance = UIViewController.initialViewControllerFromStoryBoard(OrderReviewViewController.self)
        instance?.viewModel = viewModel
        return instance
    }
    
    override func viewDidLoad() {
        bindOrderReview()
    }
    
    
    
    private func bindOrderReview() {
//
//
//        viewModel.subTotal.asObservable()
//            .bind(to: subTotal.rx.text)
//            .disposed(by: disposeBag)
//
//        viewModel.total.asObservable()
//            .bind(to: total.rx.text)
//            .disposed(by: disposeBag)
//
//        viewModel.discount.asObservable()
//            .bind(to: discount.rx.text)
//            .disposed(by: disposeBag)
//
//        viewModel.hsttax.asObservable()
//            .bind(to: hsttax.rx.text)
//            .disposed(by: disposeBag)
    }
    
    
}
