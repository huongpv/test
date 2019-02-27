//
//  FooterCell.swift
//  Test
//
//  Created by huongpv on 12/24/18.
//  Copyright © 2018 huongpv. All rights reserved.
//

import UIKit

class FooterCell: UITableViewCell {
    @IBOutlet weak var btnLogout: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        btnLogout.set(cornerRadius: 10, borderWidth: 0.5, borderColor: .white)
    }
}
