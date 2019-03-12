//
//  BackGroundImageVC.swift
//  Test
//
//  Created by Macbook on 3/11/19.
//  Copyright © 2019 huongpv. All rights reserved.
//

import UIKit

class BackGroundImageVC: UICollectionViewController {
    
    private var arrImageStr = ["wallpaper", "wallpaper", "background", "wallpaper", "background", "wallpaper", "background"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewBackgroundColor()
        
        collectionView.backgroundColor = .clear
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.contentInset = UIEdgeInsets(top: 23, left: 16, bottom: 10, right: 16)
        
        collectionView.registerNibCellFor(type: BackGroundImageCell.self)
    }
    
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImageStr.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imgStr = arrImageStr[indexPath.row]
        let cell = collectionView.reusableCell(type: BackGroundImageCell.self, indexPath: indexPath)!
        cell.setupView(str: imgStr)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let backgroundName = arrImageStr[indexPath.row]
        SharedData.backgroundImage = backgroundName
        
        let tabbarVC = TabbarVC()
        SystemBoots.instance.appDelegate?.changeRootViewControoler(viewController: tabbarVC)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension BackGroundImageVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
        return CGSize(width: itemSize, height: itemSize)
    }
}
