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
    
    @IBOutlet weak var ratingStar: UIView!
    @IBOutlet weak var titleFeild: UITextField!
    @IBOutlet weak var commentField: UITextView!
    var productId: String!
    
    private var viewModel: ReviewPostViewModel!
    private let disposeBag: DisposeBag = DisposeBag()
    
    static func createInstance(viewModel: ReviewPostViewModel) -> ReviewPostViewController? {
        let instance = UIViewController.initialViewControllerFromStoryBoard(ReviewPostViewController.self)
        instance?.viewModel = viewModel
        return instance
    }
    override func viewDidLoad() {
        setup()
        bind()
    }
    
    private func setup() {
        titleFeild.layer.cornerRadius = 5
        titleFeild.layer.borderColor = UIColor.lightGray.cgColor
        titleFeild.layer.borderWidth = 1
        commentField.layer.cornerRadius = 5
        commentField.layer.borderColor = UIColor.lightGray.cgColor
        commentField.layer.borderWidth = 1
    }
    
    private func bind() {
        viewModel.isComplete.asObservable()
            .subscribe(onNext: { isComplete in  })
            .disposed(by: disposeBag)
        
        // Alert Message
        viewModel.alertMessage.asObservable()
            .subscribe(
                onNext: { alertError in self.showAlert(alertError) }
            ).disposed(by: disposeBag)
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func postButtonPressed(_ sender: Any) {
        viewModel.postReivew(productId: productId, rating: 3, title: titleFeild.text, comment: commentField.text)
    }
}
