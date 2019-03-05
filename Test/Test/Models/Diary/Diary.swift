//
//  Diary.swift
//  Test
//
//  Created by huongpv on 2/28/19.
//  Copyright © 2019 huongpv. All rights reserved.
//

import Foundation

struct Diary: Decodable {
    var id: String?
    var title: String?
    var content: String?
    var coverUrl: String?
    var mood: String?
    var url: String?
    var publishedAt: String?
    
    // Use for language device (Vietname)
    var timeAgo: String? {
        return publishedAt?.dateBy(format: DateFormat.dateTimeWithSlash)?.formattedAsTimeAgo()
    }
    
    init(id: String, title: String, content: String, coverUrl: String, mood: String, publishedAt: String) {
        self.id = id
        self.title = title
        self.content = content
        self.coverUrl = coverUrl
        self.mood = mood
        self.publishedAt = publishedAt
    }
}

