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
import RxDataSources

class AccountViewController: BaseViewController {
    
//    @IBOutlet weak var accountTableView: UITableView!
    
    private var viewModel: AccountViewModel!
    private let disposeBag: DisposeBag = DisposeBag()
    
    @IBOutlet weak var fullnameLabel: UILabel!
    @IBOutlet weak var birthDateLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var pointLabel: UILabel!
    
    @IBOutlet weak var receiverLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var postalCodeLabel: UILabel!
    
    @IBOutlet weak var cardholderLabel: UILabel!
    @IBOutlet weak var cardNumberLabel: UILabel!
    @IBOutlet weak var expiryDateLabel: UILabel!
    
    static func createInstance(viewModel: AccountViewModel) -> AccountViewController? {
        let instance = UIViewController.initialViewControllerFromStoryBoard(AccountViewController.self)
        instance?.viewModel = viewModel
        return instance
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        viewModel.fetchUser()
        bindView() // bind data
    }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        bindView() // bind data
//    }

    private func bindView() {
        viewModel.fullName.asObservable()
            .bind(to: fullnameLabel.rx.text)
            .disposed(by: disposeBag)
        viewModel.dateOfBirth.asObservable()
            .bind(to: birthDateLabel.rx.text)
            .disposed(by: disposeBag)
        viewModel.mobileNumber.asObservable()
            .bind(to: phoneNumberLabel.rx.text)
            .disposed(by: disposeBag)
        viewModel.email.asObservable()
            .bind(to: emailLabel.rx.text)
            .disposed(by: disposeBag)
        viewModel.totalPoint.asObservable()
            .bind(to: pointLabel.rx.text)
            .disposed(by: disposeBag)
        viewModel.address.asObservable()
            .bind(to: addressLabel.rx.text)
            .disposed(by: disposeBag)
        viewModel.receiver.asObservable()
            .bind(to: receiverLabel.rx.text)
            .disposed(by: disposeBag)
        viewModel.postalCode.asObservable()
            .bind(to: postalCodeLabel.rx.text)
            .disposed(by: disposeBag)
        viewModel.cardholder.asObservable()
            .bind(to: cardholderLabel.rx.text)
            .disposed(by: disposeBag)
        viewModel.cardNumber.asObservable()
            .bind(to: cardNumberLabel.rx.text)
            .disposed(by: disposeBag)
        viewModel.expiryDate.asObservable()
            .bind(to: expiryDateLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    @IBAction func toEditProfile(_ sender: Any) {
        
        // test
//        let userInfoEditVC = resolver.resolve(UserInfoEditViewController.self)!
//        self.navigationController?.pushViewController(userInfoEditVC, animated: true)
    }
    
    
    @IBAction func editAddress(_ sender: Any) {
        if viewModel.user.value.first?.address != nil {
            let next = resolver.resolve(AddressListViewController.self)!
            
            self.navigationController?.pushViewController(next, animated: true)
//            self.parent?.addChildViewController(next)
        }
    }
    
}
