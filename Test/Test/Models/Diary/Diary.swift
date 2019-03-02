//
//  Diary.swift
//  Test
//
//  Created by huongpv on 2/28/19.
//  Copyright © 2019 huongpv. All rights reserved.
//

import Foundation

struct Diary {
    var id: Int?
    var title: String?
    var content: String?
    var coverUrl: String?
    var dateStr: String?
    var mood: String?
    var url: String?
    
    var publishedAt: Date? {
        if let dateStr = dateStr {
            return Date.dateBy(string: dateStr, format: DateFormat.dateTimeWithDash)
        }
        
        return nil
    }
    
    // Use for language device (Vietname)
    var timeAgo: String? {
        return publishedAt?.formattedAsTimeAgo()
    }
    
    init(title: String, content: String, coverUrl: String, mood: String, dateStr: String) {
        self.title = title
        self.content = content
        self.coverUrl = coverUrl
        self.mood = mood
        self.dateStr = dateStr
    }
}
