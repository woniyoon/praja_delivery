//
//  HomeViewController.swift
//  delivery
//
//  Created by Jaewon Yoon on 2018-03-12.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import Kingfisher


class HomeViewController: BaseViewController, UICollectionViewDelegate {


    // MARK: - UIView
    
    @IBOutlet weak var topSalesCollectionView: UICollectionView!
    @IBOutlet weak var youMayLikeCollectionView: UICollectionView!
    @IBOutlet weak var newProductsCollectionView: UICollectionView!
    @IBOutlet weak var trendsCollectionView: UICollectionView!
    @IBOutlet weak var banner: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var cartQty: UILabel!
    
    private var shoppingCart = ShoppingCart()
    private var cartViewModel: ShoppingCartViewModel!
    
// MARK: - Instance
    
    private var viewModel: HomeViewModel!
    private let disposeBag: DisposeBag = DisposeBag()
    
    public var keyword: String!

// MARK: - ViewController
    
    static func createInstance(viewModel: HomeViewModel) -> HomeViewController? {
        let instance = UIViewController.initialViewControllerFromStoryBoard(HomeViewController.self)
        instance?.viewModel = viewModel
        return instance
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchShoppingCartQty()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindView(viewModel: viewModel)
        configureCollectionView()
        viewModel.fetchTopSales()
        viewModel.fetchProductYouMayLike()
        viewModel.fetchNewProducts()
        searchBar.delegate = self
        
        banner.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        banner.addGestureRecognizer(tapRecognizer)
    }
    
    func imageTapped(sender: UIImageView) {
        print("Banner clicked!")
    }
    
// MARK: - Binding
    
    private func bindView(viewModel: HomeViewModel) {
        viewModel.arrOfTopSalesProduct.asObservable().bind(to: topSalesCollectionView.rx.items(cellIdentifier: CollectionViewCell.Identifier, cellType: CollectionViewCell.self))
        { row, item, cell in
            cell.item = item
            cell.addCart.addTarget(self, action: #selector(self.didTapAddToCart), for: .touchUpInside)
            }.disposed(by: disposeBag)
        
        viewModel.arrOfProductYouMayLike.asObservable().bind(to: youMayLikeCollectionView.rx.items(cellIdentifier: CollectionViewCell.Identifier, cellType: CollectionViewCell.self))
        { row, item, cell in
            cell.item = item
            cell.addCart.addTarget(self, action: #selector(self.didTapAddToCart), for: .touchUpInside)
            }.disposed(by: disposeBag)
        
        viewModel.arrOfNewProducts.asObservable().bind(to: newProductsCollectionView.rx.items(cellIdentifier: CollectionViewCell.Identifier, cellType: CollectionViewCell.self))
        { row, item, cell in
            cell.item = item
            cell.addCart.addTarget(self, action: #selector(self.didTapAddToCart), for: .touchUpInside)
            }.disposed(by: disposeBag)
       
        viewModel.arrOfTrendsKeyword.asObservable().bind(to: trendsCollectionView.rx.items(cellIdentifier: TrendsCell.Identifier, cellType: TrendsCell.self))
        { row, item, cell in
            cell.item = item
            }.disposed(by: disposeBag)
        
        viewModel.alertMessage.asObservable()
            .subscribe(
                onNext: { alertError in self.showAlert(alertError) }
        ).disposed(by: disposeBag)
        
        viewModel.qtyProductsCart.asObservable()
            .bind(to: self.cartQty.rx.text)
            .disposed(by: disposeBag)
    }

    
// MARK: - CollectionView

    private func registerCell() {
        let nib = UINib(nibName: CollectionViewCell.Identifier, bundle: nil)
        topSalesCollectionView.register(nib, forCellWithReuseIdentifier: CollectionViewCell.Identifier)
        youMayLikeCollectionView.register(nib, forCellWithReuseIdentifier: CollectionViewCell.Identifier)
        newProductsCollectionView.register(nib, forCellWithReuseIdentifier: CollectionViewCell.Identifier)
        
        let nib2 = UINib(nibName: TrendsCell.Identifier, bundle: nil)
        trendsCollectionView.register(nib2, forCellWithReuseIdentifier: TrendsCell.Identifier)
        
        topSalesCollectionView.delegate = self
        youMayLikeCollectionView.delegate = self
        newProductsCollectionView.delegate = self
        trendsCollectionView.delegate = self
    }

    private func configureCollectionView() {
        registerCell()
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width:180 , height:260)
        layout.sectionInset = UIEdgeInsets(top: 15, left: 5, bottom: 10, right: 5)
        layout.minimumLineSpacing = 1.0
        layout.minimumInteritemSpacing = 1.0
        
        youMayLikeCollectionView.setCollectionViewLayout(layout, animated: true)
        newProductsCollectionView.setCollectionViewLayout(layout, animated: true)
        topSalesCollectionView.setCollectionViewLayout(layout, animated: true)
        
        topSalesCollectionView.reloadData()
        youMayLikeCollectionView.reloadData()
        newProductsCollectionView.reloadData()
    }
    
    @IBAction func goToShoppingCart(_ sender: Any) {
        if Int(viewModel.qtyProductsCart.value) == 0 {
            self.showAlert(title: "projectName.uppercased()", message: "Shopping Cart is empty !")
        } else {
            let next = resolver.resolve(ShoppingCartViewController.self)!
//            self.present(next, animated: true, completion: nil)
            self.navigationController?.pushViewController(next, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.trendsCollectionView {
            let cell = collectionView.cellForItem(at: indexPath) as! TrendsCell
            
            let next = resolver.resolve(ProductListViewController.self)!
            next.keyword = ""
            self.navigationController?.pushViewController(next, animated: true)
            
        } else {
            let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
            
            let next = resolver.resolve(ProductDetailViewController.self)!
            next.productId = cell.item!.productId
            self.navigationController?.pushViewController(next, animated: true)
        }
    }
    
    func didTapAddToCart(sender: UIButton) -> Void {
        let cell = sender.superview?.superview?.superview as! CollectionViewCell
        
        let productId = cell.item?.productId
        
        if viewModel.productAlreadyInCart(with: productId!) {
            let projectName = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
            self.showAlert(title: projectName.uppercased(), message: "Product already added to cart !")
        } else {
            shoppingCart.idProducts = productId!
            shoppingCart.quantity = 1
            viewModel.addProductShoppingCart(with: shoppingCart)
        }
    }
}


// MARK: - SearchBar

extension HomeViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.keyword = searchText
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !self.keyword.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            let next = resolver.resolve(CheckoutViewController.self)!
            present(next, animated: true, completion: nil)
        } else {
            searchBar.endEditing(true)
        }
    }
    
    @IBAction func sideMenuTapped(_ sender: Any) {
        
        let categoryVC = UIStoryboard(name: "Category", bundle: nil).instantiateInitialViewController() as! CategoryViewController
        
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.bounds
        
        view.addSubview(blurEffectView)
        
        categoryVC.userTappedCloseButtonClosure = { [weak blurEffectView] in
            blurEffectView?.removeFromSuperview()
        }
        
        //this part needs fix
        categoryVC.userSelectedCategory = { [weak blurEffectView] in
            blurEffectView?.removeFromSuperview()
            let next = resolver.resolve(ProductListViewController.self)!
            next.keyword = ""
            self.navigationController?.pushViewController(next, animated: true)
        }
     
        categoryVC.modalTransitionStyle = .flipHorizontal
        categoryVC.modalPresentationStyle = .overFullScreen
        
        present(categoryVC, animated: true, completion: nil)
    }
}


