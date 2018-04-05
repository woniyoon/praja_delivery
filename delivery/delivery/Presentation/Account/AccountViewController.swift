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

    //This is table view(s)
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var TableView2: UITableView!
    
    // text labels
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var dateOfBirthLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var emailAddressLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    
    //image views
    @IBOutlet weak var editProfileImageView: UIImageView!
    
    
    private var viewModel: AccountViewModel!
    public var userEmail: String!
    
    private let disposeBag: DisposeBag = DisposeBag()
    
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
        
        configureTableView()

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
    
    
    //temporary account fetcher
    @IBAction func buttonPressed(_ sender: Any) {
        viewModel.fetchAccount(userEmail)
    }

    private func registerCells() {
        let payNib = UINib(nibName: AccountShippingCell.Identifier, bundle: nil)
        let addNib = UINib(nibName: AccountPaymentCell.Identifier, bundle: nil)
        TableView.register(payNib, forCellReuseIdentifier: AccountShippingCell.Identifier)
        TableView2.register(addNib, forCellReuseIdentifier: AccountPaymentCell.Identifier)
    }

    private func configureTableView() {
        registerCells()
        TableView.rowHeight = 100
    }

    private func bindCells() {
        viewModel.address.asObservable()
            .bind(to: TableView.rx.items(cellIdentifier: AccountShippingCell.Identifier, cellType: AccountShippingCell.self))                           {
                row, address, cell in
                cell.address = address
            }.disposed(by: disposeBag)
        viewModel.payment.asObservable()
            .bind(to: TableView2.rx.items(cellIdentifier: AccountPaymentCell.Identifier, cellType: AccountPaymentCell.self))                           {
                row, payment, cell in
                cell.payment = payment
            }.disposed(by: disposeBag)
    }
    
}
