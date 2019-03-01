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
    var content: String?
    var coverUrl: String?
    var readStatus: Bool?
    var publishedAt: String?
    var url: String?
    
    // Use for language device (Vietname, English)
    var timeAgo: String? {
        if let dateStr = publishedAt, let date = Date.dateWithAllFormat(dateStr: dateStr) {
            let dateObj = date as NSDate
            var timeStr = dateObj.timeAgo()
            if let timeStrMutable = timeStr, (timeStrMutable.contains("ngày trước") || timeStrMutable.contains("days ago")) {
                timeStr = date.weekDayText
            }
            return timeStr
        }
        return nil
    }
    
    init(content: String, coverUrl: String, readStatus: Bool, publishedAt: String) {
        self.content = content
        self.coverUrl = coverUrl
        self.readStatus = readStatus
        self.publishedAt = publishedAt
    }
}
