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
    var selectedIndexPath = IndexPath()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Test Change commit by rebase"
//        tableView.register(UINib(nibName: "TestCell", bundle: nil), forCellReuseIdentifier: identifier)
        print("Test Request Merge")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.cellForRow(at: selectedIndexPath)?.setSelected(false, animated: true)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = "More ways to shop: Visit an Apple Store, call 1-800-MY-APPLE, or find a reseller."
        return cell
    }
}

extension Test2VC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let abcVC = UIViewController()
        abcVC.view.backgroundColor = .red
        selectedIndexPath = indexPath
        navigationController?.pushViewController(abcVC, animated: true)
    }
}
