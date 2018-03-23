//
//  ReviewListViewController.swift
//  delivery
//
//  Created by Kento Uchida on 2018/03/23.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class ReviewListViewController: BaseViewController {
    
    var productId: String!
    
    private var viewModel: ReviewListViewModel!
    private let disposeBag: DisposeBag = DisposeBag()
    
    static func createInstance(viewModel: ReviewListViewModel) -> ReviewListViewController? {
        let instance = UIViewController.initialViewControllerFromStoryBoard(ReviewListViewController.self)
        instance?.viewModel = viewModel
        return instance
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
        viewModel.fetchReviewList(productId: productId)
    }
    
    private func bindView() {
    }
}
