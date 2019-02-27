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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        tableView.registerNibCellFor(type: FooterCell.self)
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        tableView.tableFooterView = UIView()
        
        // headerView
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 267)
        let headerView = HeaderView(frame: frame)
        tableView.tableHeaderView = headerView
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
        if indexPath.row == 2 {
            let cell = tableView.reusableCell(type: FooterCell.self)!
            cell.contentView.backgroundColor = .clear
            cell.backgroundColor = .clear
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 999)
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
            cell.backgroundColor = .clear
            cell.textLabel?.textColor = .white
            cell.accessoryType = .disclosureIndicator
            cell.selectionStyle = .none
            cell.textLabel?.text = "ABC"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("ABC")
    }
}
