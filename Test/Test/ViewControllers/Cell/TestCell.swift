//
//  TestCell.swift
//  Test
//
//  Created by huongpv on 2/27/19.
//  Copyright © 2019 huongpv. All rights reserved.
//

import UIKit
import SDWebImage

class TestCell: UITableViewCell {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var imgStatus: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupView(notification: Notification) {
        if let urlStr = notification.coverUrl, let url = URL(string: urlStr) {
            imgProfile.sd_setImage(with: url, completed: nil)
        }
        lbTitle.text = notification.content
        lbTime.text = notification.publishedAt
        imgStatus.isHidden = notification.readStatus ?? true
    }
    
}
