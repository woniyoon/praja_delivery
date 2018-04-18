//
//  ShoppingCartViewController.swift
//  delivery
//
//  Created by Bacelar on 2018-04-12.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import Firebase

class ShoppingCartViewController: BaseViewController, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    private let disposeBag: DisposeBag = DisposeBag()
    
    private var productsIds = [Int:String]()
    private var shoppingCart = ShoppingCart()
    private var viewModel: ShoppingCartViewModel!
    public var keyword: String!
    
    var gridLayout: GridLayout!
    lazy var listLayout: ListLayout = {
        var listLayout = ListLayout(itemHeight: 280)
        return listLayout }()
    
    
    static func createInstance(viewModel: ShoppingCartViewModel) -> ShoppingCartViewController? {
        let instance = UIViewController.initialViewControllerFromStoryBoard(ShoppingCartViewController.self)
        instance?.viewModel = viewModel
        return instance
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindTableView()
        collectionView.delegate = self
        gridLayout = GridLayout(numberOfColumns: 2)
        collectionView.collectionViewLayout = gridLayout
        collectionView.reloadData()
        viewModel.fetchShoppingCartList()
    }

    private func bindTableView() {
        
        viewModel.productsShoppingCart.asObservable()
        .bind(to: collectionView.rx.items(cellIdentifier: ShoppingCartCell.Identifier, cellType: ShoppingCartCell.self))
        {   row, shopppingCart, cell in
            cell.productShoppingCart = shopppingCart
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
