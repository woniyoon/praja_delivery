//
//  UsersViewController.swift
//  delivery
//
//  Created by Sara N on 2018-03-12.
//  Copyright © 2018 CICCC. All rights reserved.

import Foundation
import UIKit
import RxSwift
import RxCocoa

class UserViewController: UIViewController {
    

    @IBOutlet weak var nameLabel: UILabel!

    
    private var viewModel: UserViewModel!
    
    private let disposeBag: DisposeBag = DisposeBag()
    
    static func createInstance(viewModel: UserViewModel) -> UserViewController? {
        let instance = UIViewController.initialViewControllerFromStoryBoard(UserViewController.self)
        instance?.viewModel = viewModel
        return instance
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.firstName.asObservable().bind(to: nameLabel.rx.text).disposed(by: disposeBag)
        viewModel.fetchUser()
    }

}

