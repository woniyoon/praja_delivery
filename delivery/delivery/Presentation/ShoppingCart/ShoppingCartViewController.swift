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

class NavigationController: UINavigationController {
//    func viewDidLoad() {
//        
//    }
}

class ShoppingCartViewController: UIViewController, UICollectionViewDelegate {


    @IBOutlet weak var binButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var subTotal: UILabel!
    
    @IBOutlet weak var discount: UILabel!
    @IBOutlet weak var hsttax: UILabel!
    @IBOutlet weak var total: UILabel!
    
    private let disposeBag: DisposeBag = DisposeBag()
    
    public var shoppingCart = ShoppingCart()
    public var viewModel: ShoppingCartViewModel!
    private var editModeEnabled = false
    public var keyword: String!
    public var selectedCell: ShoppingCartCell!
    
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
        
        viewModel.total.asObservable()
            .bind(to: total.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.discount.asObservable()
            .bind(to: discount.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.hsttax.asObservable()
            .bind(to: hsttax.rx.text)
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
    
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Initialize the reusable Collection View Cell with our custom class
        let shoppingCartCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShoppingCartCell", for: indexPath) as! ShoppingCartCell
        
        
        return shoppingCartCell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if collectionView == self.collectionView {
            
            let productCell = cell as! ShoppingCartCell

            productCell.quantityButton.autoresizingMask = [.flexibleLeftMargin, .flexibleBottomMargin]
            productCell.quantityButton.setTitleColor(#colorLiteral(red: 0.5568627451, green: 0.5568627451, blue: 0.5568627451, alpha: 1), for: UIControlState.normal)
            productCell.quantityButton.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            productCell.quantityButton.layer.cornerRadius = 18
            productCell.quantityButton.layer.borderWidth = 1
            productCell.quantityButton.layer.borderColor = #colorLiteral(red: 0.5568627451, green: 0.5568627451, blue: 0.5568627451, alpha: 1)
            productCell.quantityButton.tag = indexPath.row
            productCell.quantityButton.setTitle(String(describing: productCell.productShoppingCart!.quantity), for: UIControlState.normal)
            
            productCell.quantityButton.addTarget(self, action: #selector(changeQuantityDidTap), for: UIControlEvents.touchUpInside)
            
            productCell.deleteProduct.tag = indexPath.row
            productCell.deleteProduct.addTarget(self, action: #selector(deleteItemFromCart), for: UIControlEvents.touchUpInside)
            
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
    
    func changeQuantityDidTap(sender: UIButton) -> Void {
        let storyBoard : UIStoryboard = UIStoryboard(name: "QuantityPopUpViewController", bundle:nil)
        
        let popUpViewController = storyBoard.instantiateViewController(withIdentifier: "quantityPopUp") as! QuantityPopUpController
        
        popUpViewController.loadView()
        
        selectedCell = (sender.superview?.superview) as! ShoppingCartCell

        popUpViewController.quantityView.frame.origin.x = (selectedCell.frame.maxX / 2)
        popUpViewController.quantityView.frame.origin.y = (selectedCell.frame.maxY / 2)
        popUpViewController.delegate = self
        popUpViewController.setQuantity(sender: sender)

        present(popUpViewController, animated:true, completion:nil)
    }
    
    
    @IBAction func didTapBinButton(_ sender: Any) {

        for item in collectionView.visibleCells {
            var indexpath : NSIndexPath = self.collectionView!.indexPath(for: item as! ShoppingCartCell)! as NSIndexPath
            var cell : ShoppingCartCell = self.collectionView!.cellForItem(at: indexpath as IndexPath) as! ShoppingCartCell
            
            if cell.deleteProduct.isHidden{
                cell.deleteProduct.isHidden = false
            } else {
                cell.deleteProduct.isHidden = true
            }
        }
    }
    
    func deleteItemFromCart(sender: UIButton){
        
        selectedCell = (sender.superview?.superview) as! ShoppingCartCell
        
        let id = selectedCell.productShoppingCart?.product.productId
        
        viewModel.deleteProductFromShoppingCart(with: id!)
        collectionView.reloadData()
        print(collectionView.numberOfItems(inSection: 0))
        if collectionView.numberOfItems(inSection: 0) == 1 {
            dismiss(animated: false, completion: nil)
        }
        viewModel.fetchShoppingCartList()
    }
    
}

extension ShoppingCartViewController: PopupDelegate {
    func passValue(value: String, tag: Int) {
        selectedCell.quantityButton.setTitle(value, for: .normal)

        shoppingCart.idProducts = (selectedCell.productShoppingCart?.product.productId)!
        shoppingCart.quantity = Int(value)!
        viewModel.updateProductShoppingCart(with: shoppingCart)
        
        collectionView.reloadData()
        viewModel.fetchShoppingCartList()
    }
}
