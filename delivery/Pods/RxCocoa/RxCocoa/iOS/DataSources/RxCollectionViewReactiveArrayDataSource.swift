//
//  RxCollectionViewReactiveArrayDataSource.swift
//  RxCocoa
//
//  Created by Krunoslav Zaher on 6/29/15.
//  Copyright © 2015 Krunoslav Zaher. All rights reserved.
//

#if os(iOS) || os(tvOS)

import UIKit
import RxSwift

// objc monkey business
class _RxCollectionViewReactiveArrayDataSource
    : NSObject
    , UICollectionViewDataSource {
    
    @objc(numberOfSectionsInCollectionView:)
    func numberOfSections(in: UICollectionView) -> Int {
        return 1
    }

    func _collectionView(_ topSalesCollectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ topSalesCollectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _collectionView(topSalesCollectionView, numberOfItemsInSection: section)
    }

    fileprivate func _collectionView(_ topSalesCollectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        rxAbstractMethod()
    }

    func collectionView(_ topSalesCollectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return _collectionView(topSalesCollectionView, cellForItemAt: indexPath)
    }
}

class RxCollectionViewReactiveArrayDataSourceSequenceWrapper<S: Sequence>
    : RxCollectionViewReactiveArrayDataSource<S.Iterator.Element>
    , RxCollectionViewDataSourceType {
    typealias Element = S

    override init(cellFactory: @escaping CellFactory) {
        super.init(cellFactory: cellFactory)
    }
    
    func collectionView(_ topSalesCollectionView: UICollectionView, observedEvent: Event<S>) {
        Binder(self) { collectionViewDataSource, sectionModels in
            let sections = Array(sectionModels)
            collectionViewDataSource.collectionView(topSalesCollectionView, observedElements: sections)
        }.on(observedEvent)
    }
}


// Please take a look at `DelegateProxyType.swift`
class RxCollectionViewReactiveArrayDataSource<Element>
    : _RxCollectionViewReactiveArrayDataSource
    , SectionedViewDataSourceType {
    
    typealias CellFactory = (UICollectionView, Int, Element) -> UICollectionViewCell
    
    var itemModels: [Element]? = nil
    
    func modelAtIndex(_ index: Int) -> Element? {
        return itemModels?[index]
    }

    func model(at indexPath: IndexPath) throws -> Any {
        precondition(indexPath.section == 0)
        guard let item = itemModels?[indexPath.item] else {
            throw RxCocoaError.itemsNotYetBound(object: self)
        }
        return item
    }
    
    var cellFactory: CellFactory
    
    init(cellFactory: @escaping CellFactory) {
        self.cellFactory = cellFactory
    }
    
    // data source
    
    override func _collectionView(_ topSalesCollectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemModels?.count ?? 0
    }
    
    override func _collectionView(_ topSalesCollectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return cellFactory(topSalesCollectionView, indexPath.item, itemModels![indexPath.item])
    }
    
    // reactive
    
    func collectionView(_ topSalesCollectionView: UICollectionView, observedElements: [Element]) {
        self.itemModels = observedElements
        
        topSalesCollectionView.reloadData()

        // workaround for http://stackoverflow.com/questions/39867325/ios-10-bug-uicollectionview-received-layout-attributes-for-a-cell-with-an-index
        topSalesCollectionView.collectionViewLayout.invalidateLayout()
    }
}

#endif
