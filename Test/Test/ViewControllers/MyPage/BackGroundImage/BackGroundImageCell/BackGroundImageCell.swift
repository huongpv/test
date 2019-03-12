//
//  BackGroundImageCell.swift
//  Test
//
//  Created by Macbook on 3/11/19.
//  Copyright © 2019 huongpv. All rights reserved.
//

import UIKit

class BackGroundImageCell: UICollectionViewCell {
    @IBOutlet weak var imgBackGround: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupView(str: String) {
        imgBackGround.image = UIImage(named: str)
    }
}
