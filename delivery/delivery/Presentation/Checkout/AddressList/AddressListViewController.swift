//
//  Checkout2.swift
//  delivery
//
//  Created by Jaewon Yoon on 2018-04-20.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class AddressListViewController: UIViewController, UITableViewDelegate {

    @IBOutlet weak var addressTableView: UITableView!
    
    private var viewModel: AddressListViewModel!
    private let disposeBag: DisposeBag = DisposeBag()
    
    static func createInstance(viewModel: AddressListViewModel) -> AddressListViewController? {
        let instance = UIViewController.initialViewControllerFromStoryBoard(AddressListViewController.self)
        instance?.viewModel = viewModel
        return instance
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        viewModel.fetchAddressList()
        addressTableView.reloadData()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        bindView()
        viewModel.fetchAddressList()
        addressTableView.delegate = self
    }
    
    func registerCell() {
        let nib = UINib(nibName: AddressListCell.Identifier, bundle: nil)
        addressTableView.register(nib, forCellReuseIdentifier: AddressListCell.Identifier)
        addressTableView.allowsSelection = false
    }

    func bindView() {
        viewModel.addressList.asObservable().bind(to: addressTableView.rx.items(cellIdentifier: AddressListCell.Identifier, cellType: AddressListCell.self))
        { row, item, cell in
            cell.item = item

            cell.editButton.addTarget(self, action: #selector(self.editButtonTapped), for: UIControlEvents.touchUpInside)
            
            cell.deleteButton.addTarget(self, action: #selector(self.deleteButtonTapped), for: UIControlEvents.touchUpInside)
            
            cell.radioButton.addTarget(self, action: #selector(self.radioButtonSelected), for: UIControlEvents.touchUpInside)
            
            }.disposed(by: disposeBag)
    }
    
    func editButtonTapped(sender: UIButton) {
        let cell: AddressListCell = (sender.superview?.superview?.superview) as! AddressListCell
        
        let index : IndexPath = self.addressTableView.indexPath(for: cell)!
        print(index.row)
        let addressEditVC = resolver.resolve(AddressEditViewController.self)!
        addressEditVC.indexNumberOfAddress = index.row
        self.navigationController?.pushViewController(addressEditVC, animated: true)
    }
    
    func deleteButtonTapped(sender: UIButton) {
        let cell: AddressListCell = (sender.superview?.superview?.superview) as! AddressListCell
        let index : IndexPath = self.addressTableView.indexPath(for: cell)!

        var testArr = viewModel.addressList.value

        if testArr.count == 1 {
            print("at least one address should be registered!")
        } else {
            if testArr[index.row].isDefault == true {
                testArr.remove(at: index.row)
                if let firstItem = testArr.first {
                    let newItem = Address(receiver: firstItem.receiver, address1: firstItem.address1, address2: firstItem.address2, city: firstItem.city, province: firstItem.province, postalCode: firstItem.postalCode, country: firstItem.country, isDefault: true, phoneNumber: firstItem.phoneNumber)
                    
                    testArr.removeFirst()
                    testArr.insert(newItem, at: 0)
                }
            } else {
                testArr.remove(at: index.row)
            }
            
            viewModel.addressList.accept(testArr)
        }
    }

    func radioButtonSelected(sender: UIButton) {
            let cell: AddressListCell = (sender.superview?.superview) as! AddressListCell
            
            let index : IndexPath = self.addressTableView.indexPath(for: cell)!
            print(index.row)

        let originalArr = viewModel.addressList.value
        var testArr: [Address] = []
        for i in 0..<originalArr.count {
            if i == index.row {
                let add = Address(receiver: originalArr[i].receiver, address1: originalArr[i].address1, address2: originalArr[i].address2, city: originalArr[i].city, province: originalArr[i].province, postalCode: originalArr[i].postalCode, country: originalArr[i].country, isDefault: true, phoneNumber: originalArr[i].phoneNumber)
                
                testArr.append(add)

            } else {
                let add = Address(receiver: originalArr[i].receiver, address1: originalArr[i].address1, address2: originalArr[i].address2, city: originalArr[i].city, province: originalArr[i].province, postalCode: originalArr[i].postalCode, country: originalArr[i].country, isDefault: false, phoneNumber: originalArr[i].phoneNumber)
                
                testArr.append(add)
            }
        }
        viewModel.addressList.accept(testArr)
        addressTableView.reloadInputViews()
    }

    @IBAction func addButtonTapped(_ sender: Any) {
//        let next = resolver.resolve(AddressEditViewController.self)!
        let addressEditVC = resolver.resolve(AddressEditViewController.self)!
        self.navigationController?.pushViewController(addressEditVC, animated: true)
        
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        viewModel.updateAddressList().subscribe(onCompleted: {
            self.addressTableView.reloadInputViews()
//            let next = resolver.resolve(CheckoutViewController.self)!
            self.navigationController?.popViewController(animated: true)
//            self.present(next, animated: true, completion: nil)
        }) { (err) in
            print(err)
        }
    }
    
    func test() {
        viewModel.updateAddressList().subscribe(onCompleted: {
            self.addressTableView.reloadInputViews()
            //            let next = resolver.resolve(CheckoutViewController.self)!
            self.navigationController?.popViewController(animated: true)
            print("reached!!!")
            //            self.present(next, animated: true, completion: nil)
        }) { (err) in
            print(err)
        }
    }
}
