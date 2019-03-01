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
        let notifications = [Notification(content: "Cảm thấy hài lòng về thái độ tận tâm, tận lực khám chữa bệnh của các bác sỹ ở bệnh viện TW Cảm thấy hài lòng về thái độ tận tâm ...", coverUrl: "https://thumbor.forbes.com/thumbor/960x0/https%3A%2F%2Fspecials-images.forbesimg.com%2Fdam%2Fimageserve%2F42977075%2F960x0.jpg%3Ffit%3Dscale", readStatus: false, publishedAt: "28/02/2019 08:13:59"),
                             Notification(content: "Cảm thấy hài lòng về thái độ tận tâm", coverUrl: "https://thumbor.forbes.com/thumbor/960x0/https%3A%2F%2Fspecials-images.forbesimg.com%2Fdam%2Fimageserve%2F42977075%2F960x0.jpg%3Ffit%3Dscale", readStatus: false, publishedAt: "01/03/2019 08:13:59"),
                         Notification(content: "Cảm thấy hài lòng về thái độ tận tâm, tận lực khám chữa bệnh của các bác sỹ", coverUrl: "https://thumbor.forbes.com/thumbor/960x0/https%3A%2F%2Fspecials-images.forbesimg.com%2Fdam%2Fimageserve%2F42977075%2F960x0.jpg%3Ffit%3Dscale", readStatus: false, publishedAt: "26/02/2019 08:13:59"),
                         Notification(content: "Cảm thấy hài lòng về thái độ tận tâm, tận lực khám chữa bệnh của các bác sỹ ở bệnh viện TW Cảm thấy hài lòng về thái độ tận tâm ...", coverUrl: "https://thumbor.forbes.com/thumbor/960x0/https%3A%2F%2Fspecials-images.forbesimg.com%2Fdam%2Fimageserve%2F42977075%2F960x0.jpg%3Ffit%3Dscale", readStatus: true, publishedAt: "22/02/2019 08:13:59"),
                         Notification(content: "Cảm thấy hài lòng về thái độ tận tâm, tận lực khám chữa bệnh của các bác sỹ ở bệnh viện TW Cảm thấy hài lòng về thái độ tận tâm ...", coverUrl: "https://thumbor.forbes.com/thumbor/960x0/https%3A%2F%2Fspecials-images.forbesimg.com%2Fdam%2Fimageserve%2F42977075%2F960x0.jpg%3Ffit%3Dscale", readStatus: true, publishedAt: "21/02/2019 08:13:59")]
        
        let delayTime = DispatchTime.now() + Double(Int64(2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            callBack(notifications)
        }
    }
}
