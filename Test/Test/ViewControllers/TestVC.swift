//
//  TestVC.swift
//  Test
//
//  Created by huongpv on 12/24/18.
//  Copyright © 2018 huongpv. All rights reserved.
//

import UIKit

class TestVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableView: UITableView!
    
    let identifier = "Cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setGradientBackgroundNav(startColor: .green, endColor: .blue, gradientDirection: .leftToRight)
        
        navigationItem.title = "Hồ sơ"
        
        setUpdateTableView()
        
        let backgroundImage = UIImage(named: "wallpaper.pnp")
        view.backgroundColor = UIColor(patternImage: backgroundImage ?? UIImage())
    }
    
    private func setUpdateTableView() {
        tableView = UITableView(frame: view.frame)
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.registerNibCellFor(type: TestCell.self)
        tableView.separatorStyle = .none
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        
        // headerView
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 267)
        let headerView = HeaderView(frame: frame)
        tableView.tableHeaderView = headerView
        
        // footerView
        let footerFrame = CGRect(x: 0, y: 20, width: view.frame.width, height: 37)
        let footerView = FooterView(frame: footerFrame)
        tableView.tableFooterView = footerView
        
    }

    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.reusableCell(type: TestCell.self)!
        cell.lbTitle.textColor = .white
        cell.lbTitle.text = "ABC"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("ABC")
    }
}
