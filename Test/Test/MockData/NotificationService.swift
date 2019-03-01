//
//  NotificationService.swift
//  Test
//
//  Created by huongpv on 2/28/19.
//  Copyright © 2019 huongpv. All rights reserved.
//

import Foundation

class NotificationService {
    //the service delivers mocked data
    func getNotificationServices(_ callBack: @escaping ([Notification]) -> Void) {
        let notification = Notification(title: "Nhật ký của tôi",
                                        content: "Kỷ nguyên mới của những chiếc smartphone màn hình gập đã chính thức bắt đầu, với việc Samsung ra mắt Galaxy Fold và Huawei ra mắt Mate X. Trong khi như thường lệ, Apple vẫn “bình chân như vại” và có vẻ như chưa có ý định ra mắt một chiếc iPhone màn hình gập.",
                                        coverUrl: "https://thumbor.forbes.com/thumbor/960x0/https%3A%2F%2Fspecials-images.forbesimg.com%2Fdam%2Fimageserve%2F42977075%2F960x0.jpg%3Ffit%3Dscale",
                                        mood: "Vui vẽ",
                                        publishedAt: "21/02/2018 13:13:59")
        
        let notification2 = Notification(title: "Nhật ký của tôi",
                                        content: "Kỷ nguyên mới của những chiếc smartphone màn hình gập đã chính thức bắt đầu, với việc Samsung ra mắt Galaxy Fold và Huawei ra mắt Mate X.",
                                        coverUrl: "https://thumbor.forbes.com/thumbor/960x0/https%3A%2F%2Fspecials-images.forbesimg.com%2Fdam%2Fimageserve%2F42977075%2F960x0.jpg%3Ffit%3Dscale",
                                        mood: "Vui vẽ",
                                        publishedAt: "21/02/2018 13:13:59")
        
        let notifications = [notification, notification2, notification, notification, notification]
        
        let delayTime = DispatchTime.now() + Double(Int64(2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            callBack(notifications)
        }
    }
}
