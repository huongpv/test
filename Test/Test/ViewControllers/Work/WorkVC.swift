//
//  WorkVC.swift
//  Test
//
//  Created by Macbook on 3/1/19.
//  Copyright © 2019 huongpv. All rights reserved.
//

import UIKit
import FirebaseAuth

class WorkVC: UITableViewController {
    
    // MARK: -Variables
    private let presenter = WorkPresenter(service: DiaryService())
    private var works = [WorkDB]()
    
    // Mark: -View life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPlusButtonInNavBar(selector: #selector(handleAddDiary))
        
        setViewBackgroundColorBy(imageNamed: "login-mohini")
        
        presenter.attachViewController(self)
        
        navigationController?.navigationBar.setGradientBackgroundNav(startColor: #colorLiteral(red: 0.09803921569, green: 0.568627451, blue: 0.9215686275, alpha: 1), endColor: #colorLiteral(red: 0.1764705882, green: 0.631372549, blue: 0.9725490196, alpha: 1), gradientDirection: .leftToRight)
        
        navigationItem.title = "my_work".localized
        
        tableView.setup(input: self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 70
        tableView.registerNibCellFor(type: WorkCell.self)
    }
    
    @objc func handleAddDiary() {
        let createWorkVC = CreateWorkVC()
        createWorkVC.delegate = self
        navigationController?.pushViewController(createWorkVC, animated: true)
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return works.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let workDB = works[indexPath.row]
        let cell = tableView.reusableCell(type: WorkCell.self)!
        cell.setupView(workDB: workDB)
        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let workDB = works[indexPath.row]
        let createWorkVC = CreateWorkVC()
        createWorkVC.delegate = self
        createWorkVC.workDB = workDB
        VCService.push(controller: createWorkVC)
    }
    
}

// MARK: -DiaryProtocol
extension WorkVC: WorkProtocol {
    
    func startLoading() {
        IndicatorViewer.show()
    }
    
    func finishLoading() {
        IndicatorViewer.hide()
    }
    
    func setWorks(_ works: [WorkDB]) {
        self.works = works
        tableView.reloadData()
    }
    
}

// MARK: -CreateDiaryDelegate
extension WorkVC: CreateWorkDelegate {
    func didAddWork(work: WorkDB) {
        works.append(work)
        let newIndexPath = IndexPath(row: works.count - 1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
        tableView.scrollToBottom()
    }

    func didUpdateWork(work: WorkDB) {
        let index = works.index(of: work)
        let indexPath = IndexPath(row: index!, section: 0)
        tableView.reloadRows(at: [indexPath], with: .middle)
    }

}
