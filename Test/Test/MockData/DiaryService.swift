//
//  DiaryService.swift
//  Test
//
//  Created by huongpv on 2/28/19.
//  Copyright © 2019 huongpv. All rights reserved.
//

import Foundation

class DiaryService {
    //the service delivers mocked data
    func getDiaryServices(_ callBack: @escaping (_ diarys: [Diary]?, _ error: Error?) -> Void) {
        let diary = Diary(title: "Nhật ký của tôi",
                                        content: "Kỷ nguyên mới của những chiếc smartphone màn hình gập đã chính thức bắt đầu, với việc Samsung ra mắt Galaxy Fold và Huawei ra mắt Mate X. Trong khi như thường lệ, Apple vẫn “bình chân như vại” và có vẻ như chưa có ý định ra mắt một chiếc iPhone màn hình gập.",
                                        coverUrl: "https://thumbor.forbes.com/thumbor/960x0/https%3A%2F%2Fspecials-images.forbesimg.com%2Fdam%2Fimageserve%2F42977075%2F960x0.jpg%3Ffit%3Dscale",
                                        mood: "Vui vẽ",
                                        dateStr: "21/02/2018 13:13:59")
        
        let diary2 = Diary(title: "Nhật ký của tôi Nhật ký của tôi Nhật ký của tôi",
                                         content: "Kỷ nguyên mới của những chiếc smartphone màn hình gập đã chính thức bắt đầu, với việc Samsung ra mắt Galaxy Fold và Huawei ra mắt Mate X.",
                                         coverUrl: "https://thumbor.forbes.com/thumbor/960x0/https%3A%2F%2Fspecials-images.forbesimg.com%2Fdam%2Fimageserve%2F42977075%2F960x0.jpg%3Ffit%3Dscale",
                                         mood: "Vui vẽ",
                                         dateStr: "01/03/2019 13:13:59")
        
        let diarys = [diary, diary2, diary, diary, diary]
        
        let delayTime = DispatchTime.now() + 1.0
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            callBack(diarys, nil)
        }
    }
    
    func addDiaryToServer(diary: Diary, _ callBack: @escaping (Error?) -> Void) {
        let delayTime = DispatchTime.now() + 1.0
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            callBack(nil)
        }
    }
    
    func updateDiaryToServer(diaryDB: DiaryDB, _ callBack: @escaping (Error?) -> Void) {
        let delayTime = DispatchTime.now() + 1.0
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            callBack(nil)
        }
    }
}
