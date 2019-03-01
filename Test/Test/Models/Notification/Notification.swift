//
//  Notification.swift
//  Test
//
//  Created by huongpv on 2/28/19.
//  Copyright © 2019 huongpv. All rights reserved.
//

import Foundation

struct Notification {
    var id: Int?
    var title: String?
    var content: String?
    var coverUrl: String?
    var publishedAt: String?
    var mood: String?
    var url: String?
    
    // Use for language device (Vietname)
    var timeAgo: String? {
        if let dateStr = publishedAt, let date = Date.dateBy(string: dateStr, format: DateFormat.dateTimeWithDash) {
            return date.formattedAsTimeAgo()
        }
        return nil
    }
    
    init(title: String, content: String, coverUrl: String, mood: String, publishedAt: String) {
        self.title = title
        self.content = content
        self.coverUrl = coverUrl
        self.mood = mood
        self.publishedAt = publishedAt
    }
}
