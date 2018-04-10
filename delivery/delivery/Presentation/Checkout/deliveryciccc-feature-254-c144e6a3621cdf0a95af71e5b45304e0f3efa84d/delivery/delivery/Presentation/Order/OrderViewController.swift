//
//  OrderViewController.swift
//  delivery
//
//  Created by MATSUHISA MAI on 2018/03/12.
//  Copyright © 2018年 CICCC. All rights reserved.
//
import Foundation
import UIKit
import RxSwift
import RxCocoa

internal class OrderViewController : UIViewController {

    private var viewModel: OrderViewModel!
    
    @IBOutlet weak var orderName: UILabel!
    
    private let disposeBag: DisposeBag = DisposeBag()
    
    static func createInstance(viewModel: OrderViewModel) -> OrderViewController? {
        let instance = UIViewController.initialViewControllerFromStoryBoard(OrderViewController.self)
        instance?.viewModel = viewModel
        return instance
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
        viewModel.fetchOrder("test")
        
    }
    
    private func bindView() {
        viewModel.name.asObservable()
            .bind(to: orderName.rx.text)
            .disposed(by: disposeBag)
    }
}
