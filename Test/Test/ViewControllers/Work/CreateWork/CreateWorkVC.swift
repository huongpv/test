//
//  CreateWorkVC.swift
//  Test
//
//  Created by Macbook on 3/2/19.
//  Copyright © 2019 huongpv. All rights reserved.
//

import UIKit

// MARK :- CreateCompanyDelegate
protocol CreateWorkDelegate {
    func didAddWork(work: WorkDB)
    func didUpdateWork(work: WorkDB)
}

class CreateWorkVC: UIViewController {
    // MARK: -Outlets
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var tvContent: UITextView!
    
    // MARK: -Constraints
    @IBOutlet weak var constraintHeightContentView: NSLayoutConstraint!
    @IBOutlet weak var constraintHeightMoodTextView: NSLayoutConstraint!
    
    private let createWorkPresenter = CreateWorkPresenter(workService: DiaryService())
    private var date = Date()
    private var mood = ""
    
    var delegate: CreateWorkDelegate?
    var workDB: WorkDB?
    
    private func updateView() {
        if let workDB = workDB {
            txtTitle.text = workDB.title
            tvContent.text = workDB.content
            date = workDB.publishedAt ?? Date()
            mood = workDB.mood ?? ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        constraintHeightContentView.constant = view.frame.height + 20 // not correct
        print(constraintHeightContentView.constant)

        updateView()
        
        createWorkPresenter.attachViewController(self)
        
        setViewBackgroundColorBy()
        setupSaveButtonInNavBar(selector: #selector(handleSave))
    }
    
    @objc private func handleSave() {
        if workDB == nil {
            addwork()
        } else {
            updatework()
        }
    }
    
    private func addwork() {
        let title = txtTitle.text
        let content = tvContent.text
        let coverUrl = "https://thumbor.forbes.com/thumbor/960x0/https%3A%2F%2Fspecials-images.forbesimg.com%2Fdam%2Fimageserve%2F42977075%2F960x0.jpg%3Ffit%3Dscale"
        
        createWorkPresenter.addworkToServer(title: title ?? "", content: content ?? "", coverUrl: coverUrl, publishedAt: date, mood: mood) { (workDB, error) in
            if let error = error {
                print(error)
            } else {
                guard let workDB = workDB else { return }
                self.delegate?.didAddWork(work: workDB)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    private func updatework() {
        workDB?.title = txtTitle.text
        workDB?.content = tvContent.text
        workDB?.mood = mood
        workDB?.publishedAt = date
        guard let workDB = workDB else { return }
        
        createWorkPresenter.updateworkToServer(workDB: workDB) { (error) in
            if let updateErr = error {
                print("Failed to update work", updateErr)
            } else {
                self.delegate?.didUpdateWork(work: workDB)
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

// MARK: -CreateworkProtocol
extension CreateWorkVC: CreateWorkProtocol {
    func startLoading() {
        IndicatorViewer.show()
    }
    
    func finishLoading() {
        IndicatorViewer.hide()
    }
    
}
