//
//  FontCell.swift
//  Test
//
//  Created by Macbook on 3/10/19.
//  Copyright © 2019 huongpv. All rights reserved.
//

import UIKit

class FontCell: UITableViewCell {

    @IBOutlet weak var lbFont: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    func setupView(fontName: String) {
        lbFont.font = UIFont(name: fontName, size: 16)
    }
    
}
