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

class HomeViewController: BaseViewController, UICollectionViewDelegate {

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
    
    func tap(sender: UITapGestureRecognizer){
        if let indexPath = collectionView?.indexPathForItem(at: sender.location(in: collectionView)) {
            let cell = collectionView?.cellForItem(at: indexPath)
            print("you can do something with the cell or index path here")
        } else {
            print("collection view was tapped")
        }
    }

    
    @IBAction func getArray(_ sender: Any) {
        viewModel.fetchArrayOfProduct()
    }

    private func registerCell() {
        let nib = UINib(nibName: CollectionViewCell.Identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: CollectionViewCell.Identifier)
        
        youMayLikeCollectionView.register(nib, forCellWithReuseIdentifier: CollectionViewCell.Identifier)

        collectionView.delegate = self
    }

    private func configureTableView() {
        registerCell()
        let cellSize = CGSize(width:180 , height:200)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 1.0
        layout.minimumInteritemSpacing = 1.0
        collectionView.setCollectionViewLayout(layout, animated: true)
        youMayLikeCollectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.reloadData()
        youMayLikeCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        print(cell.item!.productId)
        
        let next = resolver.resolve(ProductDetailViewController.self)!
        next.productId = cell.item!.productId
        present(next, animated: true, completion: nil)
    }
}


