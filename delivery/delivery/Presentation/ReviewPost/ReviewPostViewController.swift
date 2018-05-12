//
//  ReviewPostViewController.swift
//  delivery
//
//  Created by Kento Uchida on 2018/05/11.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class ReviewPostViewController: BaseViewController {
    
    var productId: String!
    
    private var viewModel: ReviewPostViewModel!
    private let disposeBag: DisposeBag = DisposeBag()
    
    static func createInstance(viewModel: ReviewPostViewModel) -> ReviewPostViewController? {
        let instance = UIViewController.initialViewControllerFromStoryBoard(ReviewPostViewController.self)
        instance?.viewModel = viewModel
        return instance
    }
    override func viewDidLoad() {
        bind()
    }
    
    private func bind() {
        viewModel.isComplete.asObservable()
            .subscribe(onNext: { isComplete in  })
            .disposed(by: disposeBag)
    }
}
