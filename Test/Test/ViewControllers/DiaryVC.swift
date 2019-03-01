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
    private let notificationPresenter = NotificationPresenter(notificationService: NotificationService())
    private var notifications = [Notification]()

    // Mark: -View life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notificationPresenter.attachViewController(self)
        notificationPresenter.getNotifications()
        
        navigationController?.navigationBar.setGradientBackgroundNav(startColor: .green, endColor: .blue, gradientDirection: .leftToRight)
        
        navigationItem.title = "my_diary".localized
        
        tableView.setup(input: self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 70
        tableView.registerNibCellFor(type: TestCell.self)
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return notifications.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let notification = notifications[indexPath.row]
        let cell = tableView.reusableCell(type: TestCell.self)!
        cell.setupView(notification: notification)
        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("ABC")
    }
    
}

extension DiaryVC: NotificationProtocol {
    func startLoading() {
        IndicatorViewer.show()
    }
    
    func finishLoading() {
        IndicatorViewer.hide()
    }
    
    func setNotifications(_ notifications: [Notification]) {
        self.notifications = notifications
        tableView.reloadData()
    }
    
}
