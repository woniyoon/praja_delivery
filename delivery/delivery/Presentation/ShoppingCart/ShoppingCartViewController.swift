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

    @IBOutlet weak var binButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var subTotal: UILabel!
    private let disposeBag: DisposeBag = DisposeBag()
    
    private var shoppingCart = ShoppingCart()
    private var viewModel: ShoppingCartViewModel!
    private var editModeEnabled = false
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
        
        viewModel.subTotal.asObservable()
        .bind(to: subTotal.rx.text)
            .disposed(by: disposeBag)
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
            
            let productCell = cell as! ShoppingCartCell
            
            let productQty = UIButton(frame: CGRect(x: cell.bounds.maxX - 50, y:0, width:36,height:36))
            productQty.autoresizingMask = [.flexibleLeftMargin, .flexibleBottomMargin]
            productQty.setTitle(String(describing: productCell.productShoppingCart!.quantity), for: UIControlState.normal)
            
            productQty.setTitleColor(#colorLiteral(red: 0.5568627451, green: 0.5568627451, blue: 0.5568627451, alpha: 1), for: UIControlState.normal)
            productQty.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            productQty.layer.cornerRadius = 18
            productQty.layer.borderWidth = 1
            productQty.layer.borderColor = #colorLiteral(red: 0.5568627451, green: 0.5568627451, blue: 0.5568627451, alpha: 1)
//            addProductCart.addTarget(self, action: #selector(editButtonTapped), for: UIControlEvents.touchUpInside)
            productQty.tag = indexPath.row
            
            cell.addSubview(productQty)
        }
    }
    @IBAction func close(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    func deleteProductCell(sender:UIButton) {
//        // Put the index number of the delete button the use tapped in a variable
//        let i: Int = (sender.layer.valueForKey("index")) as Int
//        // Remove an object from the collection view's dataSource
//        imageFileNames.removeAtIndex(i)
//
//        // Refresh the collection view
//        self.collectionView!.reloadData()
    }

    
}
