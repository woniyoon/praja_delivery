//
//  CheckoutViewController.swift
//  delivery
//
//  Created by Jaewon Yoon on 2018-04-03.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class CheckoutViewController: BaseViewController {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        <#code#>
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
//
    
    @IBOutlet weak var checkoutTableView: UITableView!
    
    private var viewModel: CheckoutViewModel!
    private let disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
        configureTableView()
        viewModel.fetchUser()
    }
    
    // MARK: - ViewController
    
    static func createInstance(viewModel: CheckoutViewModel) -> CheckoutViewController? {
        let instance = UIViewController.initialViewControllerFromStoryBoard(CheckoutViewController.self)
        instance?.viewModel = viewModel
        return instance
    }
    
    
    private func bindView() {
        viewModel.address.asObservable().bind(to: checkoutTableView.rx.items(cellIdentifier: AddressCell.Identifier, cellType: AddressCell.self))
        { row, item, cell in
            print(cell)
            cell.item = item
        }.disposed(by: disposeBag)
        

//        viewModel.user.asObservable()
//            .bindTo(checkoutTableView.rx.items) { (tableView, row, element) in
//
//                print(row)
//                let indexPath = IndexPath(row: row, section: 0)
//
//                if row == 0 {
//                    let cell = tableView.dequeueReusableCell(withIdentifier: UserInfoCell.Identifier, for: indexPath) as! UserInfoCell
//                    cell.item = element
//                    return cell
//                } else {
//                    let cell = tableView.dequeueReusableCell(withIdentifier: AddressCell.Identifier, for: indexPath) as! AddressCell
//                    cell.item = element
//                    return cell
//                }
//            }
//            .disposed(by: disposeBag)
    }
    
    private func registerCell() {
        let nib = UINib(nibName: UserInfoCell.Identifier, bundle: nil)
        let nib2 = UINib(nibName: AddressCell.Identifier, bundle: nil)
        checkoutTableView.register(nib, forCellReuseIdentifier: UserInfoCell.Identifier)
        checkoutTableView.register(nib2, forCellReuseIdentifier: AddressCell.Identifier)
    }
    
    private func configureTableView() {
        registerCell()
        checkoutTableView.estimatedRowHeight = 250
        checkoutTableView.allowsSelection = false
        checkoutTableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
    }
    
}
