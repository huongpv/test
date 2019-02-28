//
//  TestVC.swift
//  Test
//
//  Created by huongpv on 12/24/18.
//  Copyright © 2018 huongpv. All rights reserved.
//

import UIKit

class TestVC: UITableViewController {

    // Mark: -View life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setGradientBackgroundNav(startColor: .green, endColor: .blue, gradientDirection: .leftToRight)
        
        navigationItem.title = "Notifications"
        
        tableView.setup(input: self)
        tableView.registerNibCellFor(type: TestCell.self)
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.reusableCell(type: TestCell.self)!
        cell.lbTitle.text = "Cảm thấy hài lòng về thái độ tận tâm, tận lực khám chữa bệnh của các bác sỹ ở bệnh viện TW Cảm thấy hài lòng về thái độ tận tâm ..."
        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("ABC")
    }
}
