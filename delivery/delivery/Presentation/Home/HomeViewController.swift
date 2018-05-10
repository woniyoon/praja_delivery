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
//        view.willRemoveSubview(blurEffectView)
        print(view.subviews.count)
        if view.subviews.count > 1 {
            view.willRemoveSubview(view.subviews[1])
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindView(viewModel: viewModel)
        configureCollectionView()
        viewModel.fetchTopSales()
        viewModel.fetchProductYouMayLike()
        viewModel.fetchNewProducts()
        searchBar.delegate = self
        
        let imageUrl:URL = URL(string: "https://firebasestorage.googleapis.com/v0/b/nomnom-562a0.appspot.com/o/banner1.png?alt=media&token=688828a0-2b28-497e-8bf9-2df3c53ba3db")!
        let resource = ImageResource(downloadURL: imageUrl, cacheKey: "banner")
        self.banner.kf.setImage(with: resource)
        
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
            }.disposed(by: disposeBag)
        
        viewModel.arrOfProductYouMayLike.asObservable().bind(to: youMayLikeCollectionView.rx.items(cellIdentifier: CollectionViewCell.Identifier, cellType: CollectionViewCell.self))
        { row, item, cell in
            cell.item = item
            }.disposed(by: disposeBag)
        
        viewModel.arrOfNewProducts.asObservable().bind(to: newProductsCollectionView.rx.items(cellIdentifier: CollectionViewCell.Identifier, cellType: CollectionViewCell.self))
        { row, item, cell in
            cell.item = item
            }.disposed(by: disposeBag)
       
        viewModel.arrOfTrendsKeyword.asObservable().bind(to: trendsCollectionView.rx.items(cellIdentifier: TrendsCell.Identifier, cellType: TrendsCell.self))
        { row, item, cell in
            cell.item = item
            }.disposed(by: disposeBag)
        
        viewModel.alertMessage.asObservable()
            .subscribe(
                onNext: { alertError in self.showAlert(alertError) }
        ).disposed(by: disposeBag)
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
        layout.itemSize = CGSize(width:180 , height:200)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 1.0
        layout.minimumInteritemSpacing = 1.0
        
        youMayLikeCollectionView.setCollectionViewLayout(layout, animated: true)
        newProductsCollectionView.setCollectionViewLayout(layout, animated: true)
        topSalesCollectionView.setCollectionViewLayout(layout, animated: true)
        
        topSalesCollectionView.reloadData()
        youMayLikeCollectionView.reloadData()
        newProductsCollectionView.reloadData()
    }
    
    @IBAction func test(_ sender: Any) {
        let nav1 = UINavigationController()
        let next = resolver.resolve(CheckoutViewController.self)!

        nav1.viewControllers = [next]
        nav1.navigationBar.topItem?.title = "Checkout"
//        nav1.topItem?.title = "Checkout"
        present(nav1, animated: true, completion: nil)
    }
    
    
    //    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
//
//        let next = resolver.resolve(ProductDetailViewController.self)!
//        next.productId = cell.item!.productId
//        present(next, animated: true, completion: nil)
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.trendsCollectionView {
            let cell = collectionView.cellForItem(at: indexPath) as! TrendsCell
            
            let next = resolver.resolve(ProductListViewController.self)!
            next.keyword = ""
            present(next, animated: true, completion: nil)
            
        } else {
            let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
            
            let next = resolver.resolve(ProductDetailViewController.self)!
            next.productId = cell.item!.productId
            present(next, animated: true, completion: nil)
        }
    }
}


// MARK: - SearchBar

extension HomeViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        self.keyword = searchText
    }
    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        if !self.keyword.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
//            let next = resolver.resolve(ProductListViewController.self)!
//            next.keyword = self.keyword
//            present(next, animated: true, completion: nil)
//        } else {
//            searchBar.endEditing(true)
//        }
//    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !self.keyword.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            let next = resolver.resolve(CheckoutViewController.self)!
            present(next, animated: true, completion: nil)
        } else {
            searchBar.endEditing(true)
        }
    }
    
    @IBAction func sideMenuTapped(_ sender: Any) {
        
        let viewController = UIStoryboard(name: "Category", bundle: nil).instantiateInitialViewController() as! CategoryViewController
        
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        //always fill the view
        blurEffectView.frame = self.view.bounds
        
        view.addSubview(blurEffectView)
        viewController.userTappedCloseButtonClosure = { [weak blurEffectView] in
            blurEffectView?.removeFromSuperview()
        }
     
        viewController.modalTransitionStyle = .flipHorizontal
        viewController.modalPresentationStyle = .overFullScreen
        
        present(viewController, animated: true, completion: nil)
    }
}


