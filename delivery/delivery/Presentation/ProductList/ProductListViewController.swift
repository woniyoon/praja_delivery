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
    
    @IBOutlet weak var collectionView: UICollectionView!
    private let disposeBag: DisposeBag = DisposeBag()
    
    private var viewModel: ProductListViewModel!
    public var keyword: String!

    var gridLayout: GridLayout!
    lazy var listLayout: ListLayout = {
        var listLayout = ListLayout(itemHeight: 280)
        return listLayout }()
    
    override func viewWillAppear(_ animated: Bool) {
        print("test")
        self.tabBarController?.tabBar.isTranslucent = false
    }
    
    static func createInstance(viewModel: ProductListViewModel) -> ProductListViewController? {
        let instance = UIViewController.initialViewControllerFromStoryBoard(ProductListViewController.self)
        instance?.viewModel = viewModel
        return instance
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindTableView()
        viewModel.fetchProductList(with: self.keyword)
        
        gridLayout = GridLayout(numberOfColumns: 2)
        collectionView.collectionViewLayout = gridLayout
        collectionView.reloadData()
    }
    
    private func bindTableView() {
        viewModel.productsList.asObservable()
            .bind(to: collectionView.rx.items(cellIdentifier: ProductsCell.Identifier, cellType: ProductsCell.self))
            { row, product, cell in
                cell.product = product
            }.disposed(by: disposeBag)
    }

    
    @IBAction func gridPressed(_ sender: Any) {
        if collectionView.collectionViewLayout == gridLayout {
            // list layout
            UIView.animate(withDuration: 0.1, animations: {
                self.collectionView.collectionViewLayout.invalidateLayout()
                self.collectionView.setCollectionViewLayout(self.listLayout, animated: false)
            })
        } else {
            // grid layout
            UIView.animate(withDuration: 0.1, animations: {
                self.collectionView.collectionViewLayout.invalidateLayout()
                self.collectionView.setCollectionViewLayout(self.gridLayout, animated: false)
            })
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
}
