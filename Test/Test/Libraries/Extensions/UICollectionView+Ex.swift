//
//  UICollectionView+Ex.swift
//  iOS Structure MVC
//
//  Created by huongpv on 1/8/19.
//  Copyright © 2019 vinhdd. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
    // MARK: - Register functions
    func setup(input: UICollectionViewDataSource & UICollectionViewDelegate) {
        delegate = input
        dataSource = input
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
    }
    
    func registerNibCellFor<T: UICollectionViewCell>(type: T.Type) {
        let nibName = UIView.getNameFor(type: type)
        register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: nibName)
    }
    
    func registerClassCellFor<T: UICollectionViewCell>(type: T.Type) {
        let nibName = UIView.getNameFor(type: type)
        register(type, forCellWithReuseIdentifier: nibName)
    }
    
    // MARK: - Get component functions
    func reusableCell<T: UICollectionViewCell>(type: T.Type, indexPath: IndexPath) -> T? {
        let nibName = UIView.getNameFor(type: type)
        return self.dequeueReusableCell(withReuseIdentifier: nibName, for: indexPath) as? T
    }
}
