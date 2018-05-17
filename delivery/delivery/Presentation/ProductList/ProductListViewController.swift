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
import RealmSwift
import RxSwift
import Firebase


class ProductListViewController: BaseViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var cartQty: UILabel!
    
    @IBOutlet weak var dropDown: UIView!
    private let disposeBag: DisposeBag = DisposeBag()
    
    private var productsIds = [Int:String]()
    private var shoppingCart = ShoppingCart()
    private var viewModel: ProductListViewModel!
    private var cartViewModel: ShoppingCartViewModel!
    public var keyword: String!


    var gridLayout: GridLayout!
    lazy var listLayout: ListLayout = {
        var listLayout = ListLayout(itemHeight: 280)
        return listLayout }()
    
    override func viewWillAppear(_ animated: Bool) {
//        self.navigationController?.isNavigationBarHidden = false
    }
    
    static func createInstance(viewModel: ProductListViewModel) -> ProductListViewController? {
        let instance = UIViewController.initialViewControllerFromStoryBoard(ProductListViewController.self)
        instance?.viewModel = viewModel
        return instance
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        bindTableView()
        bindCartQty()
        
        viewModel.fetchProductList(with: "", by: "name", false)
        viewModel.fetchShoppingCartQty()
        
        gridLayout = GridLayout(numberOfColumns: 2)
        collectionView.collectionViewLayout = gridLayout
        collectionView.reloadData()
        dropDownShadow()
    }
    
    private func bindCartQty(){
        
        viewModel.qtyProductsCart.asObservable()
            .bind(to: self.cartQty.rx.text)
            .disposed(by: disposeBag)
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
            
            addProductCart.tag = indexPath.row + 1
            productsIds[addProductCart.tag] = productCell.product?.productId
            
            
            cell.addSubview(addProductCart)
        }
    }
    
    @IBAction func editButtonTapped(sender: UIButton?) -> Void {
        
        let myPrimaryKey = productsIds[sender!.tag]
    
        if viewModel.productAlreadyInCart(with: myPrimaryKey!) {
            let projectName = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
            let alertController = UIAlertController(title: projectName.uppercased(), message:
                "Product already added to cart !", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel,handler: nil))
            
            present(alertController, animated: true, completion: nil)
            
        } else {
            shoppingCart.idProducts = productsIds[sender!.tag]!
            shoppingCart.quantity = 1
            shoppingCart.id = sender!.tag
            viewModel.addProductShoppingCart(with: shoppingCart)
            print("Product added to cart \(sender!.tag) \(String(describing: productsIds[sender!.tag]))")
            
        }
    }
    
    @IBAction func fetchTest(sender: UIButton?) -> Void {

        let list = viewModel.productsList.value
        
        print("Shopping Cart \(viewModel.fetchShoppingCart())")
        
    }
    
    @IBAction func shoppingCartTapped(_ sender: Any) {
        let next = resolver.resolve(ShoppingCartViewController.self)!
        
        present(next, animated: true, completion: nil)
    }

    @IBAction func didTapOrderBy(_ sender: Any) {
        
        if dropDown.isHidden {
            dropDown.isHidden = false
            UIView.animate(withDuration: 0.3, animations: {
                self.dropDown.alpha = 1
            }, completion:  nil)
        } else {
            UIView.animate(withDuration: 0.3/*Animation Duration second*/, animations: {
                self.dropDown.alpha = 0
            }, completion:  {
                (value: Bool) in
                self.dropDown.isHidden = true
            })
        }
    }
    
    func dropDownShadow() {
        dropDown.backgroundColor = UIColor.white
        dropDown.layer.shadowColor = UIColor.lightGray.cgColor
        dropDown.layer.shadowOpacity = 1
        dropDown.layer.shadowOffset = CGSize(width: 7.0, height: 7.0)
        dropDown.layer.shadowRadius = 5
    }
}
