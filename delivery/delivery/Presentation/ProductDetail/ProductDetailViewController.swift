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

class ProductDetailViewController: UIViewController {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var originalPriceLabel: UILabel!
    
    private let disposeBag: DisposeBag = DisposeBag()
    
    private var viewModel: ProductDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ProductDetailViewModel()
        // Bind views and variables
        viewModel.name().bind(to: nameLabel.rx.text).disposed(by: disposeBag)
        viewModel.price().bind(to: priceLabel.rx.text).disposed(by: disposeBag)
        viewModel.originalPrice().bind(to: originalPriceLabel.rx.text).disposed(by: disposeBag)
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        viewModel.setSampleData()
    }
}
