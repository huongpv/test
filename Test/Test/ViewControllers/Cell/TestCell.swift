//
//  TestCell.swift
//  Test
//
//  Created by huongpv on 2/27/19.
//  Copyright © 2019 huongpv. All rights reserved.
//

import UIKit
import SDWebImage
import NSDate_TimeAgo

class TestCell: UITableViewCell {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var imgStatus: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        imgProfile.setCorner(27)
    }

    func setupView(notification: Notification) {
        if let urlStr = notification.coverUrl, let url = URL(string: urlStr) {
            imgProfile.sd_setImage(with: url, completed: nil)
        }
        lbTitle.text = notification.content
        if let dateStr = notification.publishedAt, let date = Date.dateWithAllFormat(dateStr: dateStr) {
            let dateObj = date as NSDate
            lbTime.text = dateObj.timeAgo()
        }
        imgStatus.isHidden = notification.readStatus ?? true
    }
    
}
