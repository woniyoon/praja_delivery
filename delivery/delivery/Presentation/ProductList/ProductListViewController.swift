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


class ProductListViewController: BaseViewController {
    
    @IBOutlet weak var productList: UITableView!
    private let disposeBag: DisposeBag = DisposeBag()
    
    private var viewModel: ProductListViewModel!

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
        bindView()
        configureTableView()
        viewModel.fetchProductList()
    }
    
    private func bindView() {
        viewModel.productsList.asObservable()
            .bind(to: productList.rx.items(cellIdentifier: ProductsCell.Identifier, cellType: ProductsCell.self))
            { row, product, cell in
                cell.product = product
            }.disposed(by: disposeBag)
    }
    
    private func registerCell() {
        let nib = UINib(nibName: ProductsCell.Identifier, bundle: nil)
        productList.register(nib, forCellReuseIdentifier: ProductsCell.Identifier)
    }
    
    private func configureTableView() {
        registerCell()
        productList.showsVerticalScrollIndicator = false
        productList.rowHeight = 156
    }
    
    
}
