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

    func setupView(diaryDB: DiaryDB) {
        if let urlStr = diaryDB.coverUrl, let url = URL(string: urlStr) {
            imgProfile.sd_setImage(with: url, completed: nil)
        }
        lbTitle.text = diaryDB.title
        lbTitle.font = UIFont(name: SharedData.fontName ?? "SFUIText", size: 17)
        
        lbMood.text = diaryDB.mood
        lbMood.font = UIFont(name: SharedData.fontName ?? "SFUIText", size: 12)
        
        lbContent.text = diaryDB.content
        lbContent.font = UIFont(name: SharedData.fontName ?? "SFUIText", size: 16)
        
        lbTime.text = diaryDB.publishedAt?.formattedAsTimeAgo()
        lbTime.font = UIFont(name: SharedData.fontName ?? "SFUIText", size: 12)
    }
    
}
