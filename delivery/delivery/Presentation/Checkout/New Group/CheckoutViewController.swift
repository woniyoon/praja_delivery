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
                    cell.item = element.address
                    return cell
                } else {
                    let cell = tv.dequeueReusableCell(withIdentifier: PaymentCell.Identifier) as! PaymentCell
                    cell.item = element.payment
                    return cell
                }
        })
        

//        checkoutTableView.rx
//            .itemSelected
//            .subscribe(onNext:  { [weak self] indexPath in
//                print(indexPath)
//                self?.checkoutTableView.deselectRow(at: indexPath, animated: true)
//
//                print(indexPath)
////                let next = resolver.resolve(AddressEditViewController.self)!
////                self?.present(next, animated: true, completion: nil)
//            })
//            .disposed(by: disposeBag)
        
//        checkoutTableView.rx
//            .itemSelected
//            .map { indexPath in
//                return (indexPath, dataSource[indexPath])
//            }
//            .subscribe(onNext: { pair in
//                print(pair)
//            })
//            .disposed(by: disposeBag)
//
        checkoutTableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
           self.viewModel.user.asObservable()
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

        if indexPath.section == 0 {
            print("\(indexPath.row)th row is tapped!")
        } else if indexPath.section == 1 {
            let next = resolver.resolve(AddressEditViewController.self)!
            present(next, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 2))
        return footer
    }
}
