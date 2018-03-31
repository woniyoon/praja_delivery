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

class ProductDetailViewController: BaseViewController {
    
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
    
    // ページングして表示させる ViewControllerを保持する
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
    }
    
    private func setup() {
        viewModel.fetchProductDetail(productId)
        
        for index in 0...9 {
            let vc = storyboard?.instantiateViewController(withIdentifier: "ProductImageViewController") as! ProductImageViewController
            vc.labelStr = index.description
            vcArray.append(vc)
        }

        // ContainerView に Embed した UIPageViewController を取得する
        pageViewController = childViewControllers[0] as? UIPageViewController
        
        // dataSource を設定する
        pageViewController!.dataSource = self
        
        // 最初に表示する画面として配列の先頭の ViewController を設定する
        pageViewController!.setViewControllers([vcArray[0]], direction: .forward, animated: false, completion: nil)
    }
    
    private func bindView() {
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
    
    @IBAction func buttonPressed(_ sender: Any) {
    }
    
    @IBAction func reviewListButtonPressed(_ sender: Any) {
        let next = resolver.resolve(ReviewListViewController.self)!
        next.productId = "oVhTC6TXjU1a3bG8EabF"
        present(next, animated: true, completion: nil)
    }
}

extension ProductDetailViewController: UIPageViewControllerDataSource {
    
    // 逆方向にページ送りした時に呼ばれるメソッド
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let index = vcArray.index(of: viewController as! ProductImageViewController), index > 0 else {
            return nil
        }
        
        return vcArray[index - 1]
    }
    
    // 順方向にページ送りした時に呼ばれるメソッド
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let index = vcArray.index(of: viewController as! ProductImageViewController), index < vcArray.count - 1 else {
            return nil
        }
        
        return vcArray[index + 1]
    }
}
