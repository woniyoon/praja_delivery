//
//  ProductListViewController.swift
//  delivery
//
//  Created by Bacelar on 2018-03-12.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class ProductListViewController: UIViewController {
    
    @IBOutlet weak var productName: UILabel!
    
    private var viewModel: ProductListViewModel!
    private let disposeBag: DisposeBag = DisposeBag()
    
    static func createInstance(viewModel: ProductListViewModel) -> ProductListViewController? {
        let instance = UIViewController.initialViewControllerFromStoryBoard(ProductListViewController.self)
        instance?.viewModel = viewModel
        return instance
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
        viewModel.fetchProductList()
    }

    private func bindView() {
        viewModel.productName.asObservable()
            .bind(to: productName.rx.text)
            .disposed(by: disposeBag)
    }
    
}
