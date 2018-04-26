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
        let next = resolver.resolve(AddressEditViewController.self)!
        next.indexNumberOfAddress = index.row
        present(next, animated: true, completion: nil)
    }
    
    func deleteButtonTapped(sender: UIButton) {
        let cell: AddressListCell = (sender.superview?.superview?.superview) as! AddressListCell
        let index : IndexPath = self.addressTableView.indexPath(for: cell)!

        var testArr = viewModel.addressList.value
        if testArr[index.row].isDefault == true {
            testArr.remove(at: index.row)
//            testArr[index.row-1].isDefault = true
        } else {
            testArr.remove(at: index.row)
        }
        
        viewModel.addressList.accept(testArr)
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
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footerView = UIView()
        let addButton = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        addButton.setImage(#imageLiteral(resourceName: "new"), for: .normal)
        
        footerView.addSubview(addButton)
        addButton.topAnchor.constraint(equalTo: footerView.topAnchor).isActive = true
        addButton.bottomAnchor.constraint(equalTo: footerView.bottomAnchor).isActive = true
        addButton.leadingAnchor.constraint(equalTo: footerView.leadingAnchor).isActive = true
        addButton.trailingAnchor.constraint(equalTo: footerView.trailingAnchor).isActive = true
        addButton.translatesAutoresizingMaskIntoConstraints = false

        addButton.isUserInteractionEnabled = true
        
        addButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)

        return footerView
    }
    
    func buttonAction(sender:UIButton!){
        let next = resolver.resolve(AddressEditViewController.self)!
        present(next, animated: true, completion: nil)
    }
}
