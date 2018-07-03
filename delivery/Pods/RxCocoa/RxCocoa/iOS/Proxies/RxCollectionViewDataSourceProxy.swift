//
//  RxCollectionViewDataSourceProxy.swift
//  RxCocoa
//
//  Created by Krunoslav Zaher on 6/29/15.
//  Copyright © 2015 Krunoslav Zaher. All rights reserved.
//

#if os(iOS) || os(tvOS)

import UIKit
import RxSwift

extension UICollectionView: HasDataSource {
    public typealias DataSource = UICollectionViewDataSource
}

let collectionViewDataSourceNotSet = CollectionViewDataSourceNotSet()

final class CollectionViewDataSourceNotSet
    : NSObject
    , UICollectionViewDataSource {


    func collectionView(_ topSalesCollectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(_ topSalesCollectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        rxAbstractMethod(message: dataSourceNotSet)
    }
    
}

/// For more information take a look at `DelegateProxyType`.
open class RxCollectionViewDataSourceProxy
    : DelegateProxy<UICollectionView, UICollectionViewDataSource>
    , DelegateProxyType 
    , UICollectionViewDataSource {

    /// Typed parent object.
    public weak private(set) var topSalesCollectionView: UICollectionView?

    /// - parameter collectionView: Parent object for delegate proxy.
    public init(topSalesCollectionView: ParentObject) {
        self.topSalesCollectionView = topSalesCollectionView
        super.init(parentObject: topSalesCollectionView, delegateProxy: RxCollectionViewDataSourceProxy.self)
    }

    // Register known implementations
    public static func registerKnownImplementations() {
        self.register { RxCollectionViewDataSourceProxy(topSalesCollectionView: $0) }
    }

    private weak var _requiredMethodsDataSource: UICollectionViewDataSource? = collectionViewDataSourceNotSet

    // MARK: delegate

    /// Required delegate method implementation.
    public func collectionView(_ topSalesCollectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (_requiredMethodsDataSource ?? collectionViewDataSourceNotSet).collectionView(topSalesCollectionView, numberOfItemsInSection: section)
    }
    
    /// Required delegate method implementation.
    public func collectionView(_ topSalesCollectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return (_requiredMethodsDataSource ?? collectionViewDataSourceNotSet).collectionView(topSalesCollectionView, cellForItemAt: indexPath)
    }

    /// For more information take a look at `DelegateProxyType`.
    open override func setForwardToDelegate(_ forwardToDelegate: UICollectionViewDataSource?, retainDelegate: Bool) {
        _requiredMethodsDataSource = forwardToDelegate ?? collectionViewDataSourceNotSet
        super.setForwardToDelegate(forwardToDelegate, retainDelegate: retainDelegate)
    }
}

#endif
