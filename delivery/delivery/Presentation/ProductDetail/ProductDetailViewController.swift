//
//  ProductDetailViewController.swift
//  delivery
//
//  Created by Kento Uchida on 2018/03/05.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import Cosmos

class ProductDetailViewController: BaseViewController, UICollectionViewDelegate {
    
    @IBOutlet weak var imageCollection: UICollectionView!
    @IBOutlet weak var pageControls: UIPageControl!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var originalPriceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ratingStars: CosmosView!
    
    // Review
    @IBOutlet weak var reviewRatingStars: CosmosView!
    
    @IBOutlet weak var frequentlyCollection: UICollectionView!
    @IBOutlet weak var relatedCollection: UICollectionView!
    
    @IBOutlet weak var numOfProduct: UILabel!
    
    public var viewModel: ProductDetailViewModel!
    public var productId: String!
    
    var pageViewController: UIPageViewController?
    
    var vcArray = [ProductImageViewController]()
    
    private let disposeBag: DisposeBag = DisposeBag()
    
    static func createInstance(viewModel: ProductDetailViewModel) -> ProductDetailViewController? {
        let instance = UIViewController.initialViewControllerFromStoryBoard(ProductDetailViewController.self)
        instance?.viewModel = viewModel
        return instance
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bindView()
        configureCollectionView()
    }
    
    var mainImageCellHeight: CGFloat {
        return view.frame.width
    }
    
    private lazy var mainImageCollectionViewlayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 380)
        layout.minimumLineSpacing = 0
        return layout
    }()
    
    private lazy var productCollectionViewlayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width:180 , height:200)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 1.0
        layout.minimumInteritemSpacing = 1.0
        return layout
    }()
    
    private func setup() {
        viewModel.fetchProductDetail(productId)
        viewModel.fetchFrequentlyPurchasedWith(productId)
        viewModel.fetchRelatedTo(productId)
        
        imageCollection.isPagingEnabled = true
        imageCollection.showsHorizontalScrollIndicator = false
        imageCollection.setCollectionViewLayout(mainImageCollectionViewlayout, animated: false)
        
        imageCollection.delegate = self
        
        pageControls.hidesForSinglePage = true
        
        frequentlyCollection.setCollectionViewLayout(productCollectionViewlayout, animated: true)
        relatedCollection.setCollectionViewLayout(productCollectionViewlayout, animated: true)
    }
    
    private func bindView() {
        viewModel.images.asObservable()
            .bind(to: imageCollection.rx.items(cellIdentifier: ProductImageCell.Identifier, cellType: ProductImageCell.self))
            { row, imageUrl, cell in
                cell.imageUrl = imageUrl
            }.disposed(by: disposeBag)
        viewModel.images.asObservable().subscribe(
            onNext: { images in
                self.pageControls.numberOfPages = images.count
        }).disposed(by: disposeBag)
        viewModel.name.asObservable()
            .bind(to: nameLabel.rx.text)
            .disposed(by: disposeBag)
        viewModel.price.asObservable()
            .bind(to: priceLabel.rx.text)
            .disposed(by: disposeBag)
        viewModel.originalPrice.asObservable()
            .bind(to: originalPriceLabel.rx.text)
            .disposed(by: disposeBag)
        viewModel.reviewAverage.asObservable()
            .bind(to: ratingStars.rx_rating)
            .disposed(by: disposeBag)
        viewModel.description.asObservable()
            .bind(to: descriptionLabel.rx.text)
            .disposed(by: disposeBag)
        
        // Review
        viewModel.reviewAverage.asObservable()
            .bind(to: reviewRatingStars.rx_rating)
            .disposed(by: disposeBag)
        
        // Frequent Products
        viewModel.frequentlyPurchasedWith.asObservable()
            .bind(to: frequentlyCollection.rx.items(
                cellIdentifier: CollectionViewCell.Identifier,
                cellType: CollectionViewCell.self))
            { row, item, cell in
                cell.item = item
            }.disposed(by: disposeBag)
        // Related Products
        viewModel.relatedTo.asObservable()
            .bind(to: relatedCollection.rx.items(
                cellIdentifier: CollectionViewCell.Identifier,
                cellType: CollectionViewCell.self))
            { row, item, cell in
                cell.item = item
            }.disposed(by: disposeBag)
        
        viewModel.numOfProduct.asObservable()
            .map { num in String(num) }
            .bind(to: numOfProduct.rx.text)
            .disposed(by: disposeBag)
        
        // Alert Message
        viewModel.alertMessage.asObservable()
            .subscribe(
                onNext: { alertError in self.showAlert(alertError) }
            ).disposed(by: disposeBag)
    }
    
    private func registerCell() {
        let productImageNib = UINib(nibName: ProductImageCell.Identifier, bundle: nil)
        imageCollection.register(productImageNib, forCellWithReuseIdentifier: ProductImageCell.Identifier)
        
        let productNib = UINib(nibName: CollectionViewCell.Identifier, bundle: nil)
        frequentlyCollection.register(productNib, forCellWithReuseIdentifier: CollectionViewCell.Identifier)
        relatedCollection.register(productNib, forCellWithReuseIdentifier: CollectionViewCell.Identifier)
    }
    
    private func configureCollectionView() {
        registerCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageControls.currentPage = (Int(collectionView.contentOffset.x) / Int(collectionView.frame.width))
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        viewModel.fetchProductDetail(productId)
    }
    
    @IBAction func reviewListButtonPressed(_ sender: Any) {
        let next = resolver.resolve(ReviewListViewController.self)!
        next.productId = "oVhTC6TXjU1a3bG8EabF"
        present(next, animated: true, completion: nil)
    }
    
    @IBAction func incrementButtonPressed(_ sender: Any) {
        viewModel.changeNumOfProduct(isIncrement: true)
    }

    @IBAction func decrementButtonPressed(_ sender: Any) {
        viewModel.changeNumOfProduct(isIncrement: false)
    }
    
    @IBAction func addToCartButton(_ sender: Any) {
        viewModel.addToCart()
    }
    
}
