//
//  DiaryCell.swift
//  Test
//
//  Created by huongpv on 2/27/19.
//  Copyright © 2019 huongpv. All rights reserved.
//

import UIKit
import SDWebImage

class WorkCell: UITableViewCell {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbMood: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        imgProfile.setCorner(25)
    }

    func setupView(workDB: WorkDB) {
//        if let urlStr = workDB.coverUrl, let url = URL(string: urlStr) {
//            imgProfile.sd_setImage(with: url, completed: nil)
//        }
        lbTitle.text = workDB.title
        lbTitle.font = UIFont(name: SharedData.fontName ?? "SFUIText", size: 17)
        
        lbMood.text = workDB.mood
        lbMood.font = UIFont(name: SharedData.fontName ?? "SFUIText", size: 12)
        
        lbContent.text = workDB.content
        lbContent.font = UIFont(name: SharedData.fontName ?? "SFUIText", size: 16)
        
        lbTime.text = workDB.publishedAt?.formattedAsTimeAgo()
        lbTime.font = UIFont(name: SharedData.fontName ?? "SFUIText", size: 12)
    }
    
}
