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
import Firebase

class HomeViewController: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var originalPrice: UILabel!
    
    
    private var viewModel: HomeViewModel!
    private let disposeBag: DisposeBag = DisposeBag()
    
    static func createInstance(viewModel: HomeViewModel) -> HomeViewController? {
        let instance = UIViewController.initialViewControllerFromStoryBoard(HomeViewController.self)
        instance?.viewModel = viewModel
        return instance
    }
    
    @IBAction func dbTest(_ sender: Any) {
        let db = Firestore.firestore()
        
        db.collection("products").document("oVhTC6TXjU1a3bG8EabF").getDocument { (querySnapshot, err) in
            if let err = err {
                print(err)
            } else {
                if let qs = querySnapshot {
                    print(qs.data()!["name"])
                }
            }
        }
        
        viewModel.fetchProducts()
    }
    

    
    private func bindView() {
        viewModel.name.asObservable()
            .bind(to: name.rx.text)
            .disposed(by: disposeBag)
        viewModel.price.asObservable()
            .bind(to: price.rx.text)
            .disposed(by: disposeBag)
        viewModel.originalPrice.asObservable()
            .bind(to: originalPrice.rx.text)
            .disposed(by: disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
//        viewModel.fetchProducts()
    }

}
