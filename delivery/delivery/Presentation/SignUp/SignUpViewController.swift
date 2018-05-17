//
//  SignUpViewController.swift
//  delivery
//
//  Created by Kento Uchida on 2018/05/16.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SignUpViewController: BaseViewController {
    
    // MARK: - Private Properties
    private var viewModel: SignUpViewModel!
    private let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - Static Fuctions
    static func createInstance(viewModel: SignUpViewModel) -> SignUpViewController? {
        let instance = UIViewController.initialViewControllerFromStoryBoard(SignUpViewController.self)
        instance?.viewModel = viewModel
        return instance
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        
    }
}
