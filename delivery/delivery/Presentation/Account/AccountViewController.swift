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

class AccountViewController: BaseViewController, UICollectionViewDelegate {
    
    // text labels
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var dateOfBirthLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var emailAddressLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    
    
    //image views
    @IBOutlet weak var editProfileImageView: UIImageView!
    @IBOutlet weak var editAddressImageView: UIImageView!
    @IBOutlet weak var editPaymentImageView: UIImageView!

    
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
        
        //Edit Profile:
        editProfileImageView.isUserInteractionEnabled = true
        let editProfileIV: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(editProfileIVAction))
        editProfileImageView.addGestureRecognizer(editProfileIV)
        
        //Edit Address:
        editAddressImageView.isUserInteractionEnabled = true
        let editAddressIV: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(editAddressIVAction))
        editAddressImageView.addGestureRecognizer(editAddressIV)
        
        //Edit Payment:
        editPaymentImageView.isUserInteractionEnabled = true
        let editPaymentIV: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(editPaymentIVAction))
        editPaymentImageView.addGestureRecognizer(editPaymentIV)
        
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
        //Edit Profile:
        print("edit profile!")
    }
    
    func editAddressIVAction(){
        //Edit Address:
        print("edit address!")
            shippingCollection.reloadData()
    }
    
    func editPaymentIVAction(){
        //Edit Payment:
        print("edit payment!")
            paymentCollection.reloadData()
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

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.shippingCollection {
            let cell = collectionView.cellForItem(at: indexPath) as! AccountShippingCell
            
            //delegate test
            print(cell.address?.address1 as Any)
        } else {
            let cell = collectionView.cellForItem(at: indexPath) as! AccountPaymentCell
            
            //delegate test
            print(cell.payment!.holderName)
        }
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
