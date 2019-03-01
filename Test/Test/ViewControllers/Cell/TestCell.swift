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
    @IBOutlet weak var lbMood: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    @IBOutlet weak var lbTime: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()

        imgProfile.setCorner(27)
    }

    func setupView(notification: Notification) {
        if let urlStr = notification.coverUrl, let url = URL(string: urlStr) {
            imgProfile.sd_setImage(with: url, completed: nil)
        }
        lbTitle.text = notification.title
        print(lbTitle.font.fontName)
        lbMood.text = notification.mood
        print(lbMood.font.fontName)
        lbContent.text = notification.content
        lbTime.text = notification.timeAgo
    }
    
}
