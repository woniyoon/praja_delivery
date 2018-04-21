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

class ShoppingCartViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

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
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Initialize the reusable Collection View Cell with our custom class
        let shoppingCartCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShoppingCartCell", for: indexPath) as! ShoppingCartCell
        
        // Give the delete button an index number
        shoppingCartCell.deleteProduct.layer.setValue(indexPath.row, forKey: "index")
        
        // Add an action function to the delete button
        shoppingCartCell.deleteProduct.addTarget(self, action: "deleteProductFromCart:", for: UIControlEvents.touchUpInside)
        // Return the cell
        
        print(" section \(indexPath.section)")
        return shoppingCartCell
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
            productQty.tag = indexPath.row
    
            productCell.addSubview(productQty)
            
            // Add delete button to cell

            productCell.deleteProduct.tag = indexPath.row
            productCell.deleteProduct.addTarget(self, action: #selector(deleteProductFromCart), for: UIControlEvents.touchUpInside)
            
        }
    }
    @IBAction func close(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func checkoutPurchase(_ sender: Any) {
        viewModel.deleteShoppingCart()
        
        let projectName = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
        let alertController = UIAlertController(title: projectName.uppercased(), message:
            "Shopping Cart Deleted !", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel,handler: nil))
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func deleteProduct(_ sender: Any) {
        if(editModeEnabled == false) {
            // Put the collection view in edit mode
            self.binButton.setTitle("Done", for: .normal)
            editModeEnabled = true
            
            
            // Loop through the collectionView's visible cells
            for item in self.collectionView!.visibleCells {
                let indexPath: NSIndexPath = self.collectionView!.indexPath(for: item as! ShoppingCartCell)! as NSIndexPath
                let cell: ShoppingCartCell = self.collectionView.cellForItem(at: indexPath as IndexPath) as! ShoppingCartCell!
                
                cell.deleteProduct.isHidden = false
            }
        } else {
            // Take the collection view out of edit mode
            self.binButton.setTitle("Edit", for: .normal)
            editModeEnabled = false
            
            // Loop through the collectionView's visible cells
            for item in self.collectionView!.visibleCells {
                let indexPath: NSIndexPath = self.collectionView!.indexPath(for: item as! ShoppingCartCell)! as NSIndexPath
                let cell: ShoppingCartCell = self.collectionView.cellForItem(at: indexPath as IndexPath) as! ShoppingCartCell!
                cell.deleteProduct.isHidden = true
            }
        }
    }

    
    @IBAction func deleteFromCart(_ sender: Any) {
    }
    
    
    func deleteProductFromCart(sender: UIButton?) -> Void {
        
        // Put the index number of the delete button the use tapped in a variable
        let i = (sender!.layer.value(forKey: "index"))
        // Remove an object from the collection view's dataSource
        
        // Refresh the collection view
        self.collectionView!.reloadData()

        
        let indexPath = IndexPath(row: sender!.tag, section: 1)
        
//        let cell = self.collectionView.cellForItem(at: indexPath)
//        let productCell: ShoppingCartCell = self.collectionView.cellForItem(at: indexPath) as! ShoppingCartCell!
//
//        let productId = productCell.productShoppingCart?.product.productId
//
//        self.viewModel.deleteProductFromShoppingCart(with: productId!)
        
        self.collectionView.performBatchUpdates({
            self.collectionView.deleteItems(at: [indexPath])
        }) { (finished) in
            self.collectionView.reloadItems(at: self.collectionView.indexPathsForVisibleItems)
        }

    }

}
