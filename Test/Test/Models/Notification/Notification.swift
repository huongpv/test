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
    
    init(content: String, coverUrl: String, readStatus: Bool, publishedAt: String) {
        self.content = content
        self.coverUrl = coverUrl
        self.readStatus = readStatus
        self.publishedAt = publishedAt
    }
}
