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

class AddressListViewController: UIViewController {

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
        // Do any additional setup after loading the view.
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
            cell.radioButton.isUserInteractionEnabled = true
            
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped))
            
            cell.radioButton.addGestureRecognizer(tapRecognizer)
            }.disposed(by: disposeBag)
    }
    
    func imageTapped(sender: UIImageView) {
        print("RadioButton clicked!")
    }
}
