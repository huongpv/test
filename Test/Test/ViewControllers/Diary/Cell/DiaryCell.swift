//
//  DiaryCell.swift
//  Test
//
//  Created by huongpv on 2/27/19.
//  Copyright © 2019 huongpv. All rights reserved.
//

import UIKit
import SDWebImage

class DiaryCell: UITableViewCell {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbMood: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        imgProfile.setCorner(25)
    }

    func setupView(diary: Diary) {
        if let urlStr = diary.coverUrl, let url = URL(string: urlStr) {
            imgProfile.sd_setImage(with: url, completed: nil)
        }
        lbTitle.text = diary.title
        lbMood.text = diary.mood
        lbContent.text = diary.content
        lbTime.text = diary.timeAgo
    }
    
}
