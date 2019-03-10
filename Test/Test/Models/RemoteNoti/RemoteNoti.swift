//
//  RemoteNoti.swift
//  Test
//
//  Created by Macbook on 3/10/19.
//  Copyright © 2019 huongpv. All rights reserved.
//

import SwiftyJSON

class RemoteNoti {
    var id: String?
    var notiType: String?
    var title: String?
    var content: String?
    var coverUrl: String?
    
    init(json: JSON) {
        id = json["id"].string
        notiType = json["noti_type"].string
        title = json["notification.title"].string
        content = json["notification.body"].string
        coverUrl = json["cover_url"].string
    }
}
