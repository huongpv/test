//
//  Test2VC.swift
//  Test
//
//  Created by huongpv on 12/24/18.
//  Copyright © 2018 huongpv. All rights reserved.
//

import UIKit

class Test2VC: UIViewController {
    
    let identifier = "Cell"

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Test 2"
        tableView.register(UINib(nibName: "TestCell", bundle: nil), forCellReuseIdentifier: identifier)
    }
}

// MARK: - UITableViewDataSource
extension Test2VC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! TestCell
        cell.str = "More ways to shop: Visit an Apple Store, call 1-800-MY-APPLE, or find a reseller."
        
        return cell
    }
}
