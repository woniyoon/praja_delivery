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

class ProductDetailViewController: BaseViewController {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var originalPriceLabel: UILabel!
    
    public var viewModel: ProductDetailViewModel!
    public var productId: String!
    
    private let disposeBag: DisposeBag = DisposeBag()
    
    static func createInstance(viewModel: ProductDetailViewModel) -> ProductDetailViewController? {
        let instance = UIViewController.initialViewControllerFromStoryBoard(ProductDetailViewController.self)
        instance?.viewModel = viewModel
        return instance
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
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

        viewModel.alertMessage.asObservable()
            .subscribe(
                onNext: { alertError in self.showAlert(alertError) }
            ).disposed(by: disposeBag)
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        viewModel.fetchProductDetail(productId)
    }
    
    @IBAction func reviewListButtonPressed(_ sender: Any) {
        let next = resolver.resolve(ReviewListViewController.self)!
        next.productId = "oVhTC6TXjU1a3bG8EabF"
        present(next, animated: true, completion: nil)
    }
}
