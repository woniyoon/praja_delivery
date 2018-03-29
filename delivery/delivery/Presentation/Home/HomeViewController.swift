//
//  HomeViewController.swift
//  delivery
//
//  Created by Jaewon Yoon on 2018-03-12.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class HomeViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var youMayLikeCollectionView: UICollectionView!
    
    private var viewModel: HomeViewModel!
    private let disposeBag: DisposeBag = DisposeBag()
    
    static func createInstance(viewModel: HomeViewModel) -> HomeViewController? {
        let instance = UIViewController.initialViewControllerFromStoryBoard(HomeViewController.self)
        instance?.viewModel = viewModel
        return instance
    }
    
    
    private func bindView(viewModel: HomeViewModel) {
//        viewModel.arr.asObservable()
//            .bind(to: tableView.rx.items(cellIdentifier: HomeCell.Identifier, cellType: HomeCell.self))
//            { row, item, cell in
//                cell.item = item
//            }.disposed(by: disposeBag)
//
        viewModel.arr.asObservable()
            .bind(to: collectionView.rx.items(cellIdentifier: CollectionViewCell.Identifier, cellType: CollectionViewCell.self))
            { row, item, cell in
                cell.item = item
            }.disposed(by: disposeBag)
       

        viewModel.arr.asObservable().bind(to: youMayLikeCollectionView.rx.items(cellIdentifier: CollectionViewCell.Identifier, cellType: CollectionViewCell.self))
        { row, item, cell in
            cell.item = item
            }.disposed(by: disposeBag)
        
        viewModel.alertMessage.asObservable()
            .subscribe(
                onNext: { alertError in self.showAlert(alertError) }
        ).disposed(by: disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindView(viewModel: viewModel)
        configureTableView()
        viewModel.fetchArrayOfProduct()
    }

    
    @IBAction func getArray(_ sender: Any) {
        viewModel.fetchArrayOfProduct()
    }

    private func registerCell() {
        let nib = UINib(nibName: CollectionViewCell.Identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: CollectionViewCell.Identifier)
        
        youMayLikeCollectionView.register(nib, forCellWithReuseIdentifier: CollectionViewCell.Identifier)

    }

    private func configureTableView() {
        registerCell()
//        tableView.rowHeight = 150
    }
}


