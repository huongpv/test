//
//  CreateDiaryVC.swift
//  Test
//
//  Created by Macbook on 3/2/19.
//  Copyright © 2019 huongpv. All rights reserved.
//

import UIKit

// MARK :- CreateCompanyDelegate
protocol CreateDiaryDelegate {
    func didAddDiary(diary: DiaryDB)
    func didUpdateDiary(diary: DiaryDB)
}

class CreateDiaryVC: UIViewController {
    // MARK: -Outlets
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var tvContent: UITextView!
    
    // MARK: -Constraints
    @IBOutlet weak var constraintHeightContentView: NSLayoutConstraint!
    @IBOutlet weak var constraintHeightMoodTextView: NSLayoutConstraint!
    
    private let createDiaryPresenter = CreateDiaryPresenter(diaryService: DiaryService())
    private var date = Date()
    private var mood = ""
    
    var delegate: CreateDiaryDelegate?
    var diaryDB: DiaryDB?
    
    private func updateView() {
        if let diaryDB = diaryDB {
            txtTitle.text = diaryDB.title
            tvContent.text = diaryDB.content
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        constraintHeightContentView.constant = view.frame.height + 20 // not correct
        print(constraintHeightContentView.constant)

        updateView()
        
        createDiaryPresenter.attachViewController(self)
        
        setViewBackgroundColor()
        setupSaveButtonInNavBar(selector: #selector(handleSave))
    }
    
    @objc private func handleSave() {
        if diaryDB == nil {
            addDiary()
        } else {
            updateDiary()
        }
    }
    
    private func addDiary() {
        let title = txtTitle.text
        let content = tvContent.text
        let coverUrl = "https://thumbor.forbes.com/thumbor/960x0/https%3A%2F%2Fspecials-images.forbesimg.com%2Fdam%2Fimageserve%2F42977075%2F960x0.jpg%3Ffit%3Dscale"
        let diary = Diary(title: title ?? "", content: content ?? "", coverUrl: coverUrl, mood: mood, publishedAt: date)
        
        createDiaryPresenter.addDiaryToServer(diary: diary) { (diaryDB, error) in
            if let error = error {
                print(error)
            } else {
                guard let diaryDB = diaryDB else { return }
                self.delegate?.didAddDiary(diary: diaryDB)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    private func updateDiary() {
        diaryDB?.title = txtTitle.text
        diaryDB?.content = tvContent.text
        diaryDB?.mood = mood
        diaryDB?.publishedAt = date
        guard let diaryDB = diaryDB else { return }
        
        createDiaryPresenter.updateDiaryToServer(diaryDB: diaryDB) { (error) in
            if let updateErr = error {
                print("Failed to update diary", updateErr)
            } else {
                self.delegate?.didUpdateDiary(diary: diaryDB)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func btnMood(_ sender: Any) {
        mood = "Vui vẽ"
    }
    
    @IBAction func btnTime(_ sender: Any) {
        PickerViewer.showDateTimePicker(date: Date()) { (response) in
            self.date = response?.date ?? Date()
        }
    }
    
}

// MARK: -CreateDiaryProtocol
extension CreateDiaryVC: CreateDiaryProtocol {
    func startLoading() {
        IndicatorViewer.show()
    }
    
    func finishLoading() {
        IndicatorViewer.hide()
    }
    
}
