//
//  DiaryService.swift
//  Test
//
//  Created by huongpv on 2/28/19.
//  Copyright © 2019 huongpv. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import CoreData

class DiaryService {
    private var firestore: Firestore { return Firestore.firestore() }
    
    //the service delivers mocked data
    func getDiaryServices(callBack: @escaping (_ diarys: [Diary]?, _ error: Error?) -> Void) {
        let diary = Diary(title: "Nhật ký của tôi",
                                        content: "Kỷ nguyên mới của những chiếc smartphone màn hình gập đã chính thức bắt đầu, với việc Samsung ra mắt Galaxy Fold và Huawei ra mắt Mate X. Trong khi như thường lệ, Apple vẫn “bình chân như vại” và có vẻ như chưa có ý định ra mắt một chiếc iPhone màn hình gập.",
                                        coverUrl: "https://thumbor.forbes.com/thumbor/960x0/https%3A%2F%2Fspecials-images.forbesimg.com%2Fdam%2Fimageserve%2F42977075%2F960x0.jpg%3Ffit%3Dscale",
                                        mood: "Vui vẽ",
                                        publishedAt: "21/02/2018 13:13:59".dateBy(format: DateFormat.dateTimeWithDash) ?? Date())
        
        let diary2 = Diary(title: "Nhật ký của tôi Nhật ký của tôi Nhật ký của tôi",
                                         content: "Kỷ nguyên mới của những chiếc smartphone màn hình gập đã chính thức bắt đầu, với việc Samsung ra mắt Galaxy Fold và Huawei ra mắt Mate X.",
                                         coverUrl: "https://thumbor.forbes.com/thumbor/960x0/https%3A%2F%2Fspecials-images.forbesimg.com%2Fdam%2Fimageserve%2F42977075%2F960x0.jpg%3Ffit%3Dscale",
                                         mood: "Vui vẽ",
                                         publishedAt: "01/03/2019 13:13:59".dateBy(format: DateFormat.dateTimeWithDash) ?? Date())
        
        let diarys = [diary, diary2, diary, diary, diary]
        
        let delayTime = DispatchTime.now() + 1.0
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            callBack(diarys, nil)
        }
    }
    
    func addDiaryToServer(uid: String, diary: DiaryDB, callBack: @escaping (_ documentId: String?, _ error: Error?) -> Void) {
        let usersName = "users"
        let diariesName = "diaries"
        var ref: DocumentReference? = nil
        let collectionRef = firestore.collection("\(usersName)/\(uid)/\(diariesName)")
        let data: [String : Any] = ["title": diary.title ?? "",
                                    "content": diary.content ?? "",
                                    "coverUrl": diary.coverUrl ?? "",
                                    "mood": diary.mood ?? "",
                                    "publishedAt": diary.publishedAt ?? Date()]
        ref = collectionRef.addDocument(data: data) { err in
            if let err = err {
                callBack(nil, err)
            } else {
                callBack(ref?.documentID, nil)
            }
        }
    }
    
    func updateDiaryToServer(uid: String, diaryDB: DiaryDB, callBack: @escaping (Error?) -> Void) {
        let usersName = "users"
        let diariesName = "diaries"
        guard let id = diaryDB.id else { return }
        let documentRef = firestore.document("\(usersName)/\(uid)/\(diariesName)/\(id)")
        
        let data: [String : Any] = ["title": diaryDB.title ?? "",
                                    "content": diaryDB.content ?? "",
                                    "coverUrl": diaryDB.coverUrl ?? "",
                                    "mood": diaryDB.mood ?? "",
                                    "publishedAt": diaryDB.publishedAt ?? Date()]
        
        documentRef.updateData(data) { err in
            if let err = err {
                print("Error updating document: \(err)")
                callBack(err)
            } else {
                print("Document successfully updated")
                callBack(nil)
            }
        }
    }
    
    // Login
    func login(email: String, password: String, calback: @escaping (_ user: String?, _ error: Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                calback(nil, error)
            } else if let user = authResult?.user {
                calback(user.uid, nil)
            }
        }
    }
    
    func getDiariesFromServer(uid: String, callBack: @escaping (_ diaries: [DiaryDB]?, _ error: Error?) -> Void) {
        let usersName = "users"
        let diariesName = "diaries"
        
        let collectionRef = firestore.collection("\(usersName)/\(uid)/\(diariesName)")
        
        collectionRef.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                callBack(nil, err)
            } else if let documents = querySnapshot?.documents {
                var diaries = [DiaryDB]()
                let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
                documents.forEach({ (document) in
                    let diary = DiaryDB(context: privateContext)
                    let data = document.data()
                    diary.title = data["title"] as? String ?? ""
                    diary.content = data["content"] as? String ?? ""
                    diary.coverUrl = data["coverUrl"] as? String ?? ""
                    diary.mood = data["mood"] as? String ?? ""
                    diary.publishedAt = data["publishedAt"] as? Date ?? Date()

                    diaries.append(diary)
                })
                callBack(diaries, nil)
            }
        }
    }
}
