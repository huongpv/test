//
//  MyPageVC.swift
//  Test
//
//  Created by huongpv on 12/24/18.
//  Copyright © 2018 huongpv. All rights reserved.
//

import UIKit

class MyPageVC: UITableViewController {
    
    // MARK: -Private
    private let myPagePresenter = MyPagePresenter(diaryService: DiaryService())

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setGradientBackgroundNav(startColor: .green, endColor: .blue, gradientDirection: .leftToRight)
        
        navigationItem.title = "Cài đặt"
        
        myPagePresenter.attachViewController(self)
        
        setupTableView()
        
        let backgroundImage = UIImage(named: "wallpaper.pnp")
        view.backgroundColor = UIColor(patternImage: backgroundImage ?? UIImage())
    }
    
    private func setupTableView() {
        tableView.setup(input: self)
        tableView.registerNibCellFor(type: MyPageCell.self)
        
        // headerView
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 200)
        let headerView = HeaderView(frame: frame)
        tableView.tableHeaderView = headerView
        
        // footerView
        let footerFrame = CGRect(x: 0, y: 20, width: view.frame.width, height: 37)
        let footerView = FooterView(frame: footerFrame)
        footerView.myPagePresenter = myPagePresenter
        tableView.tableFooterView = footerView
        
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.reusableCell(type: MyPageCell.self)!
        cell.lbTitle.textColor = .white
        cell.lbTitle.text = "ABC"
        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("ABC")
    }
}

extension MyPageVC: MyPageProtocol {
    func startLoading() {
        IndicatorViewer.show()
    }
    
    func finishLoading() {
        IndicatorViewer.hide()
    }
    
}
