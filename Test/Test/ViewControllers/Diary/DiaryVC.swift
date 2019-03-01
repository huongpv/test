//
//  DiaryVC.swift
//  Test
//
//  Created by huongpv on 12/24/18.
//  Copyright © 2018 huongpv. All rights reserved.
//

import UIKit

class DiaryVC: UITableViewController {
    
    // MARK: -Variables
    private let diaryPresenter = DiaryPresenter(diaryService: DiaryService())
    private var diarys = [Diary]()

    // Mark: -View life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundImage = UIImage(named: "wallpaper")
        view.backgroundColor = UIColor(patternImage: backgroundImage ?? UIImage())
        
        diaryPresenter.attachViewController(self)
        diaryPresenter.getDiarys()
        
        navigationController?.navigationBar.setGradientBackgroundNav(startColor: .green, endColor: .blue, gradientDirection: .leftToRight)
        
        navigationItem.title = "my_diary".localized
        
        tableView.setup(input: self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 70
        tableView.registerNibCellFor(type: DiaryCell.self)
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return diarys.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let diary = diarys[indexPath.row]
        let cell = tableView.reusableCell(type: DiaryCell.self)!
        cell.setupView(diary: diary)
        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("ABC")
    }
    
}

extension DiaryVC: DiaryProtocol {
    func startLoading() {
        IndicatorViewer.show()
    }
    
    func finishLoading() {
        IndicatorViewer.hide()
    }
    
    func setDiarys(_ diarys: [Diary]) {
        self.diarys = diarys
        tableView.reloadData()
    }
    
}
