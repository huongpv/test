//
//  DiaryVC.swift
//  Test
//
//  Created by huongpv on 12/24/18.
//  Copyright © 2018 huongpv. All rights reserved.
//

import UIKit
import FirebaseAuth

class DiaryVC: UITableViewController {
    
    // MARK: -Variables
    private let diaryPresenter = DiaryPresenter(diaryService: DiaryService())
    private var diarys = [DiaryDB]()

    // Mark: -View life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPlusButtonInNavBar(selector: #selector(handleAddDiary))
        
        setViewBackgroundColorBy()
        
        diaryPresenter.attachViewController(self)
        
        navigationController?.navigationBar.setGradientBackgroundNav(startColor: #colorLiteral(red: 0.09803921569, green: 0.568627451, blue: 0.9215686275, alpha: 1), endColor: #colorLiteral(red: 0.1764705882, green: 0.631372549, blue: 0.9725490196, alpha: 1), gradientDirection: .leftToRight)
        
        navigationItem.title = "my_diary".localized
        
        tableView.setup(input: self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 70
        tableView.registerNibCellFor(type: DiaryCell.self)
    }
    
    @objc func handleAddDiary() {
        let createDiaryVC = CreateDiaryVC()
        createDiaryVC.delegate = self
        //let navController = UINavigationController(rootViewController: createDiaryVC)
        navigationController?.pushViewController(createDiaryVC, animated: true)
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return diarys.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let diaryDB = diarys[indexPath.row]
        let cell = tableView.reusableCell(type: DiaryCell.self)!
        cell.setupView(diaryDB: diaryDB)
        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let diaryDB = diarys[indexPath.row]
        let createDiaryVC = CreateDiaryVC()
        createDiaryVC.delegate = self
        createDiaryVC.diaryDB = diaryDB
        VCService.push(controller: createDiaryVC)
    }
    
}

// MARK: -DiaryProtocol
extension DiaryVC: DiaryProtocol {
    
    func startLoading() {
        IndicatorViewer.show()
    }
    
    func finishLoading() {
        IndicatorViewer.hide()
    }
    
    func setDiarys(_ diarys: [DiaryDB]) {
        self.diarys = diarys
        tableView.reloadData()
    }
    
}

// MARK: -CreateDiaryDelegate
extension DiaryVC: CreateDiaryDelegate {
    func didAddDiary(diary: DiaryDB) {
        diarys.append(diary)
        let newIndexPath = IndexPath(row: diarys.count - 1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
        tableView.scrollToBottom()
    }
    
    func didUpdateDiary(diary: DiaryDB) {
        let index = diarys.index(of: diary)
        let indexPath = IndexPath(row: index!, section: 0)
        tableView.reloadRows(at: [indexPath], with: .middle)
    }
    
}
