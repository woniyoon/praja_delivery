//
//  ProductListViewController.swift
//  delivery
//
//  Created by Bacelar on 2018-03-12.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift


class ProductListViewController: UIViewController {
    
    @IBOutlet weak var productList: UITableView!
    private let disposeBag: DisposeBag = DisposeBag()
    
    private var viewModel: ProductListViewModel!
    
    static func createInstance(viewModel: ProductListViewModel) -> ProductListViewController? {
        let instance = UIViewController.initialViewControllerFromStoryBoard(ProductListViewController.self)
        instance?.viewModel = viewModel
        return instance
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        bind()
    }
    
    private func registerCell() {
        let nib = UINib(nibName: ProductCellModel.Identifier, bundle: nil)
        productList.register(nib, forCellReuseIdentifier: ProductCellModel.Identifier)
    }
    
    private func configureTableView() {
        registerCell()
        productList.rowHeight = 156
    }
    
    private func bind() {
        
        viewModel.productList.asObservable()
            .bind(to: productList.rx.items(cellIdentifier: ProductCellModel.Identifier, cellType: ProductCellModel.self))                           {
                row, sampleProductModel, cell in
                cell.sampleProductModel = sampleProductModel
            }.disposed(by: disposeBag)
    }
    
}
