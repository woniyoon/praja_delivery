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

class AccountViewController: BaseViewController {
    
    // text labels
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var dateOfBirthLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var emailAddressLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    
    //image views
    @IBOutlet weak var editProfileImageView: UIImageView!
    
    
    private var viewModel: AccountViewModel!
    @IBOutlet weak var shippingCollection: UICollectionView! //shipping
    @IBOutlet weak var paymentCollection: UICollectionView! //payment
    public var userEmail: String!
    private let disposeBag: DisposeBag = DisposeBag()
    
    lazy var listLayout: ListLayout = {
        var listLayout = ListLayout(itemHeight: 100)
        return listLayout }()
    
    static func createInstance(viewModel: AccountViewModel) -> AccountViewController? {
        let instance = UIViewController.initialViewControllerFromStoryBoard(AccountViewController.self)
        instance?.viewModel = viewModel
        return instance
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            // UIImageviews as buttons begin
        
            //just a sample
            let editProfileIV: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AccountViewController.editProfileIVAction))
            editProfileImageView.addGestureRecognizer(editProfileIV)
            
            // UIImageviews as buttons end
        
        
            bindView() // bind data
            bindCells() // bind cells
            viewModel.fetchAccount(userEmail)
        
            shippingCollection.collectionViewLayout = listLayout
            paymentCollection.collectionViewLayout = listLayout
            shippingCollection.reloadData()
            paymentCollection.reloadData()


    }
    
    
    //imageviews actions begin
    func editProfileIVAction(){
        
    }
    
    //imageviews actions end
    
    
    private func bindView() {

        viewModel.fullName.asObservable()
            .bind(to: fullNameLabel.rx.text)
            .disposed(by: disposeBag)
        viewModel.dateOfBirth.asObservable()
            .bind(to: dateOfBirthLabel.rx.text)
            .disposed(by: disposeBag)
        viewModel.mobileNumber.asObservable()
            .bind(to: phoneNumberLabel.rx.text)
            .disposed(by: disposeBag)
        viewModel.email.asObservable()
            .bind(to: emailAddressLabel.rx.text)
            .disposed(by: disposeBag)
        viewModel.totalPoint.asObservable()
            .bind(to: pointsLabel.rx.text)
            .disposed(by: disposeBag)
    }

    private func bindCells() {
        viewModel.address.asObservable()
            .bind(to: shippingCollection.rx.items(cellIdentifier: AccountShippingCell.Identifier, cellType: AccountShippingCell.self))                           {
                row, address, cell in
                cell.address = address
            }.disposed(by: disposeBag)

        viewModel.payment.asObservable()
            .bind(to: paymentCollection.rx.items(cellIdentifier: AccountPaymentCell.Identifier, cellType: AccountPaymentCell.self))                           {
                row, payment, cell in
                cell.payment = payment
            }.disposed(by: disposeBag)
    }
}
