//
//  HomeViewModel.swift
//  delivery
//
//  Created by Jaewon Yoon on 2018-03-12.
//  Copyright © 2018 CICCC. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel {
    
    var name = BehaviorRelay(value: "")
    var price = BehaviorRelay(value: "")
    var originalPrice = BehaviorRelay(value: "")
    var product = BehaviorRelay(value: [])

    private let useCase: HomeUseCaseProtocol

    init(useCase: HomeUseCaseProtocol) {
        self.useCase = useCase
    }

    func fetchProducts() {
        let model = useCase.fetchProducts()
        name.accept(model.name)
        price.accept("$\(model.price)")
        originalPrice.accept("$\(model.originalPrice)")
    }
}

extension HomeViewModel: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].rowCount
    }
    
}
