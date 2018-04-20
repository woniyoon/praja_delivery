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
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Any>>(
            configureCell: { (_, tv, indexPath, element) in
                print("------------- \(indexPath)")
                if indexPath.section == 0 {
                    let cell = tv.dequeueReusableCell(withIdentifier: UserInfoCell.Identifier) as! UserInfoCell
                    let element = element as! User
                    cell.item = element
                    return cell
                } else if indexPath.section == 1 {
                    let cell = tv.dequeueReusableCell(withIdentifier: AddressCell.Identifier) as! AddressCell
                    let element = element as! Address
                    cell.item = element
                    return cell
                } else
//                    if indexPath.section == 2
                    {
                    let cell = tv.dequeueReusableCell(withIdentifier: PaymentCell.Identifier) as! PaymentCell
                    let element = element as! Payment
                    cell.item = element
                    return cell
                }
//                else if indexPath.section == 3 {
//
//                } else {
//
//                }
        }
//            ,
//            titleForHeaderInSection: { dataSource, sectionIndex in
////                print("%%%%%%%%%%%%%%%%%\(self.checkoutTableView.subviews)")
//
//                if sectionIndex == 0 {
//                    return "User Information"
//                } else if sectionIndex == 1 {
//                    return "Shipping To"
//                } else {
//                    return "Payment"
//                }
//        }
        )
        
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
        checkoutTableView.allowsSelection = false
        checkoutTableView.delegate = self
        checkoutTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        
        if section == 0 {
            let view = UIView(frame: CGRect(x: 10, y: 50, width: 80, height: 70))
            view.backgroundColor = UIColor.gray
            let button = UIButton(frame: CGRect(x: 0, y: 10, width: 60, height: 10))
            button.setTitle("User Information", for: UIControlState.normal)
            view.addSubview(button)
            return view
        } else if section == 1 {
            let view = UIView(frame: CGRect(x: 10, y: 50, width: 120, height: 70))
            view.backgroundColor = UIColor.gray
            let button = UIButton(frame: CGRect(x: 0, y: 10, width: 60, height: 10))
            
            button.translatesAutoresizingMaskIntoConstraints = true
            button.setTitle("Shipping To", for: UIControlState.normal)
            view.addSubview(button)
            return view
        }  else {
            let view = UIView(frame: CGRect(x: 10, y: 50, width: 120, height: 70))
            view.backgroundColor = UIColor.gray
            let button = UIButton(frame: CGRect(x: 0, y: 10, width: 60, height: 10))
            button.setTitle("Payment", for: UIControlState.normal)
            view.addSubview(button)
            button.addTarget(self, action: #selector(self.buttonAction), for: UIControlEvents.touchUpInside)
         
            return view
        }
    }
    
    func buttonAction(sender: UIButton!) {
//        let next = resolver.resolve(CheckoutViewController.self)!
        let next = resolver.resolve(AddressEditViewController.self)!
        present(next, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        let separatorView = UIView(frame: CGRect(x: tableView.separatorInset.left, y: footerView.frame.height, width: tableView.frame.width - tableView.separatorInset.right, height: 10))
        separatorView.backgroundColor = UIColor.white
        footerView.addSubview(separatorView)
        return footerView
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Cancel"
    }

    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete && indexPath.section == 3 {
            if editingStyle == .delete {
                viewModel.paymentTest.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        } else {
            print("test")
        }
    }
}
