//
//  AccountViewController.swift
//  delivery
//
//  Created by Diego H. Vanni on 2018-03-13.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class AccountViewController: UIViewController {
    

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var tokenLabel: UILabel!
    
    private var viewModel: AccountViewModel!
    
    private let disposeBag: DisposeBag = DisposeBag()
    
    static func createInstance(viewModel: AccountViewModel) -> AccountViewController? {
        let instance = UIViewController.initialViewControllerFromStoryBoard(AccountViewController.self)
        instance?.viewModel = viewModel
        return instance
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
    }
    
    private func bindView() {
        viewModel.email.asObservable()
            .bind(to: emailLabel.rx.text)
            .disposed(by: disposeBag)
        viewModel.password.asObservable()
            .bind(to: passwordLabel.rx.text)
            .disposed(by: disposeBag)
        viewModel.token.asObservable()
            .bind(to: tokenLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    
    @IBAction func buttonPressed(_ sender: Any) {
         viewModel.fetchAccount(123456)
    }
}

