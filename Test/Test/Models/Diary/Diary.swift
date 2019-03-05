//
//  Diary.swift
//  Test
//
//  Created by huongpv on 2/28/19.
//  Copyright © 2019 huongpv. All rights reserved.
//

import Foundation

struct Diary: Decodable {
    var id: Int?
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
    
    init(title: String, content: String, coverUrl: String, mood: String, publishedAt: String) {
        self.title = title
        self.content = content
        self.coverUrl = coverUrl
        self.mood = mood
        self.publishedAt = publishedAt
    }
    
    init(json: [String: Any]) {
        self.title = json["title"] as? String ?? ""
        self.content = json["content"] as? String ?? ""
        self.coverUrl = json["coverUrl"] as? String ?? ""
        self.mood = json["mood"] as? String ?? ""
        self.publishedAt = json["publishedAt"] as? String ?? ""
    }
}

