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
    
    private func setup() {
        viewModel.fetchProductDetail(productId)
        
        imageCollection.isPagingEnabled = true
        imageCollection.showsHorizontalScrollIndicator = false
        imageCollection.setCollectionViewLayout(mainImageCollectionViewlayout, animated: false)
        
        imageCollection.delegate = self
        
        pageControls.hidesForSinglePage = true
    }
    
    private func bindView() {
        viewModel.images.asObservable()
            .bind(to: imageCollection.rx.items(cellIdentifier: ProductImageCell.Identifier, cellType: ProductImageCell.self))
            { row, imageUrl, cell in
                cell.imageUrl = imageUrl
            }.disposed(by: disposeBag)
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

        viewModel.alertMessage.asObservable()
            .subscribe(
                onNext: { alertError in self.showAlert(alertError) }
            ).disposed(by: disposeBag)
    }
    
    private func registerCell() {
        let nib = UINib(nibName: ProductImageCell.Identifier, bundle: nil)
        imageCollection.register(nib, forCellWithReuseIdentifier: ProductImageCell.Identifier)
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
    }
    
    @IBAction func reviewListButtonPressed(_ sender: Any) {
        let next = resolver.resolve(ReviewListViewController.self)!
        next.productId = "oVhTC6TXjU1a3bG8EabF"
        present(next, animated: true, completion: nil)
    }
}
