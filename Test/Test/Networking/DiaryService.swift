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

class DiaryService {
    private var firestore: Firestore { return Firestore.firestore() }
    
    //the service delivers mocked data
    func getDiaryServices(callBack: @escaping (_ diarys: [Diary]?, _ error: Error?) -> Void) {
        let diary = Diary(id: "abc", title: "Nhật ký của tôi",
                                        content: "Kỷ nguyên mới của những chiếc smartphone màn hình gập đã chính thức bắt đầu, với việc Samsung ra mắt Galaxy Fold và Huawei ra mắt Mate X. Trong khi như thường lệ, Apple vẫn “bình chân như vại” và có vẻ như chưa có ý định ra mắt một chiếc iPhone màn hình gập.",
                                        coverUrl: "https://thumbor.forbes.com/thumbor/960x0/https%3A%2F%2Fspecials-images.forbesimg.com%2Fdam%2Fimageserve%2F42977075%2F960x0.jpg%3Ffit%3Dscale",
                                        mood: "Vui vẽ",
                                        publishedAt: "21/02/2018 13:13:59")
        
        let diary2 = Diary(id: "xyz", title: "Nhật ký của tôi Nhật ký của tôi Nhật ký của tôi",
                                         content: "Kỷ nguyên mới của những chiếc smartphone màn hình gập đã chính thức bắt đầu, với việc Samsung ra mắt Galaxy Fold và Huawei ra mắt Mate X.",
                                         coverUrl: "https://thumbor.forbes.com/thumbor/960x0/https%3A%2F%2Fspecials-images.forbesimg.com%2Fdam%2Fimageserve%2F42977075%2F960x0.jpg%3Ffit%3Dscale",
                                         mood: "Vui vẽ",
                                         publishedAt: "01/03/2019 13:13:59")
        
        let diarys = [diary, diary2, diary, diary, diary]
        
        let delayTime = DispatchTime.now() + 1.0
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            callBack(diarys, nil)
        }
    }
    
    func addDiaryToServer(uid: String, diary: DiaryDB, callBack: @escaping (_ documentId: String?, _ error: Error?) -> Void) {
        let usersName = "users"
        let diariesName = "diaries"
        let newDocRef = firestore.collection("\(usersName)/\(uid)/\(diariesName)").document()
        let id = newDocRef.documentID
        let data: [String : Any] = ["id": id,
                                    "title": diary.title ?? "",
                                    "content": diary.content ?? "",
                                    "coverUrl": diary.coverUrl ?? "",
                                    "mood": diary.mood ?? "",
                                    "publishedAt": diary.publishedAt?.stringBy(format: DateFormat.dateTimeWithSlash) ?? ""]
        newDocRef.setData(data) { (err) in
            if let err = err {
                callBack(nil, err)
            } else {
                callBack(id, nil)
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
                                    "publishedAt": diaryDB.publishedAt?.stringBy(format: DateFormat.dateTimeWithSlash) ?? ""]
        
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
    func login(email: String, password: String, calback: @escaping (_ user: User?, _ error: Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                calback(nil, error)
            } else  {
                calback(authResult?.user, nil)
            }
        }
    }
    
    // SignUp
    func signup(displayName: String, email: String, password: String, calback: @escaping (_ user: User?, _ error: Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                calback(nil, error)
            } else  {
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = displayName
                changeRequest?.commitChanges { (error) in
                    calback(authResult?.user, nil)
                }
//                calback(authResult?.user, nil)
            }
        }
    }
    
    func getDiariesFromServer(uid: String, callBack: @escaping (_ diaries: [Diary]?, _ error: Error?) -> Void) {
        let usersName = "users"
        let diariesName = "diaries"
        
        let collectionRef = firestore.collection("\(usersName)/\(uid)/\(diariesName)")
        
        collectionRef.getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                callBack(nil, err)
            } else {
                do {
                    guard let querySnapshot = querySnapshot else { return }
                    let diaries: [Diary] = try querySnapshot.decoded()
                    callBack(diaries, nil)
                } catch let error {
                    callBack(nil, error)
                }

            }
        }
    }
    
    func logout(calback: @escaping (_ error: Error?) -> Void) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            calback(nil)
        } catch let signOutError {
            print ("Error signing out: %@", signOutError)
            calback(signOutError)
        }
        
    }
    
    func forgotPassword(email: String, calback: @escaping (_ error: Error?) -> Void) {
        let firebaseAuth = Auth.auth()
        firebaseAuth.languageCode = "vn"
        firebaseAuth.sendPasswordReset(withEmail: email) { (error) in
            calback(error)
        }
    }
}
