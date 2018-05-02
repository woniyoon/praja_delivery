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
import RxDataSources

class CheckoutViewController: BaseViewController, UITableViewDelegate {
    
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
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, User>>(
            configureCell: { (_, tv, indexPath, element) in
                if indexPath.section == 0 {
                    let cell = tv.dequeueReusableCell(withIdentifier: UserInfoCell.Identifier) as! UserInfoCell
                    let element = element
                    cell.item = element
                
                    return cell
                } else if indexPath.section == 1 {
                    let cell = tv.dequeueReusableCell(withIdentifier: AddressCell.Identifier) as! AddressCell
                    if element.address != nil {
                        cell.item = element.address!
                        return cell
                    }
                    return cell
                } else {
                    let cell = tv.dequeueReusableCell(withIdentifier: PaymentCell.Identifier) as! PaymentCell
                    cell.item = element.payment
                    return cell
                }
        })
        
        checkoutTableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
           self.viewModel.dataForSection.asObservable()
                .bind(to: checkoutTableView.rx.items(dataSource: dataSource))
                .disposed(by: disposeBag)
    }

    
    private func registerCell() {
        let nib = UINib(nibName: UserInfoCell.Identifier, bundle: nil)
        let nib2 = UINib(nibName: AddressCell.Identifier, bundle: nil)
        let nib3 = UINib(nibName: PaymentCell.Identifier, bundle: nil)
        checkoutTableView.register(nib, forCellReuseIdentifier: UserInfoCell.Identifier)
        checkoutTableView.register(nib2, forCellReuseIdentifier: AddressCell.Identifier)
        checkoutTableView.register(nib3, forCellReuseIdentifier: PaymentCell.Identifier)
    }
    
    private func configureTableView() {
        registerCell()
        checkoutTableView.estimatedRowHeight = 300
        checkoutTableView.allowsSelection = true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let next = resolver.resolve(CheckoutViewController.self)!
        tableView.deselectRow(at: indexPath, animated: false)

        var isMember: Bool
        
        if indexPath.section == 0 {
            if viewModel.user.value.count > 0 {
                isMember = true
            } else {
                isMember = false
            }
            
            let next = resolver.resolve(UserInfoEditViewController.self)!
            next.isMember = isMember
            present(next, animated: true, completion: nil)

        } else if indexPath.section == 1 {
            if viewModel.user.value.first?.address != nil {
                let next = resolver.resolve(AddressListViewController.self)!
                present(next, animated: true, completion: nil)
            } else {
                let next = resolver.resolve(AddressEditViewController.self)!
                present(next, animated: true, completion: nil)            }
            
//            let next = resolver.resolve(AddressListViewController.self)!
//            next.isMember = isMember
//            present(next, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 2))
        return footer
    }
}