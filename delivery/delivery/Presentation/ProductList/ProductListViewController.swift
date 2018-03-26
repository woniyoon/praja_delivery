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
import Firebase


class ProductListViewController: UIViewController {
    
    @IBOutlet weak var productList: UITableView!
    private let disposeBag: DisposeBag = DisposeBag()
    
    private var viewModel: ProductListViewModel!
    private var cellView: ProductCellModel!

    @IBAction func pressed(_ sender: Any) {

        let db = Firestore.firestore()
        db.collection("products")
            .getDocuments() { (document, error) in
                if let error = error {
                    print(error)
                    return
                }
                for document in document!.documents {
                    if (document.data() as? Dictionary<String, AnyObject>) != nil {
                        guard let product = ProductEntity(dictionary: document.data()) else { return }
                        print("Product name \(product.name)")
                    }

                }
        }
    }
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
        
//        viewModel.products.asObservable()
//            .bind(to: productList.rx.items(cellIdentifier: ProductCellModel.Identifier, cellType: ProductCellModel.self))                           {
//                                row, product, cell in
//                                cell.product = product
//                            }.disposed(by: disposeBag)
        
//        viewModel.productList.asObservable()
//            .bind(to: productList.rx.items(cellIdentifier: ProductCellModel.Identifier, cellType: ProductCellModel.self))                           {
//                row, product, cell in
//                cell.product = product
//            }.disposed(by: disposeBag)
        
        
    }
    
}
