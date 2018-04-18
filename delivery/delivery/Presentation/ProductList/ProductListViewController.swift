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


class ProductListViewController: BaseViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    private let disposeBag: DisposeBag = DisposeBag()
    
    private var productsIds = [Int:String]()
    private var shoppingCart = ShoppingCart()
    private var viewModel: ProductListViewModel!
    public var keyword: String!

    var gridLayout: GridLayout!
    lazy var listLayout: ListLayout = {
        var listLayout = ListLayout(itemHeight: 280)
        return listLayout }()
    
    
    static func createInstance(viewModel: ProductListViewModel) -> ProductListViewController? {
        let instance = UIViewController.initialViewControllerFromStoryBoard(ProductListViewController.self)
        instance?.viewModel = viewModel
        return instance
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        bindTableView()
        viewModel.fetchProductList(with: "")
        
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
 

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if collectionView == self.collectionView {
            
            let productCell = cell as! ProductsCell
                        
            let addProductCart = UIButton(frame: CGRect(x: cell.bounds.maxX - 50, y:0, width:50,height:50))
            addProductCart.autoresizingMask = [.flexibleLeftMargin, .flexibleBottomMargin]
            addProductCart.setImage(#imageLiteral(resourceName: "addcart"), for: UIControlState.normal)
            addProductCart.addTarget(self, action: #selector(editButtonTapped), for: UIControlEvents.touchUpInside)
            
            let fetchCart = UIButton(frame: CGRect(x:150, y:100, width:40,height:40))
            fetchCart.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
            fetchCart.setImage(#imageLiteral(resourceName: "search"), for: UIControlState.normal)
            fetchCart.addTarget(self, action: #selector(fetchTest), for: UIControlEvents.touchUpInside)
            
            addProductCart.tag = indexPath.row
            productsIds[addProductCart.tag] = productCell.product?.productId
            
            cell.addSubview(addProductCart)
            cell.addSubview(fetchCart)
        }
    }
    
    @IBAction func editButtonTapped(sender: UIButton?) -> Void {
        
        shoppingCart.idProducts = productsIds[sender!.tag]!
        shoppingCart.quantity = 1
        shoppingCart.id = sender!.tag
        viewModel.addProductShoppingCart(with: shoppingCart)
        print("Porduct added to cart \(sender!.tag) \(productsIds[sender!.tag])")
        
    }
    
    @IBAction func fetchTest(sender: UIButton?) -> Void {

        let list = viewModel.productsList.value
        
        print("Shopping Cart \(viewModel.fetchShoppingCart())")
        
    }
    
    @IBAction func shoppingCartTapped(_ sender: Any) {
        let next = resolver.resolve(ShoppingCartViewController.self)!
        present(next, animated: true, completion: nil)
    }
    
    
}
