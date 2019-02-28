//
//  TestVC.swift
//  Test
//
//  Created by huongpv on 12/24/18.
//  Copyright © 2018 huongpv. All rights reserved.
//

import UIKit

class TestVC: UITableViewController {
    
    // MARK: -Variables
    var notifications = [Notification]()
    

    // Mark: -View life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeMockData()
        
        navigationController?.navigationBar.setGradientBackgroundNav(startColor: .green, endColor: .blue, gradientDirection: .leftToRight)
        
        navigationItem.title = "Notifications"
        
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
    
    private func makeMockData() {
        notifications = [Notification(content: "Cảm thấy hài lòng về thái độ tận tâm, tận lực khám chữa bệnh của các bác sỹ ở bệnh viện TW Cảm thấy hài lòng về thái độ tận tâm ...", coverUrl: "https://thumbor.forbes.com/thumbor/960x0/https%3A%2F%2Fspecials-images.forbesimg.com%2Fdam%2Fimageserve%2F42977075%2F960x0.jpg%3Ffit%3Dscale", readStatus: false, publishedAt: "28/02/2019"),
                         Notification(content: "Cảm thấy hài lòng về thái độ tận tâm", coverUrl: "https://thumbor.forbes.com/thumbor/960x0/https%3A%2F%2Fspecials-images.forbesimg.com%2Fdam%2Fimageserve%2F42977075%2F960x0.jpg%3Ffit%3Dscale", readStatus: false, publishedAt: "27/02/2019"),
                         Notification(content: "Cảm thấy hài lòng về thái độ tận tâm, tận lực khám chữa bệnh của các bác sỹ", coverUrl: "https://thumbor.forbes.com/thumbor/960x0/https%3A%2F%2Fspecials-images.forbesimg.com%2Fdam%2Fimageserve%2F42977075%2F960x0.jpg%3Ffit%3Dscale", readStatus: false, publishedAt: "26/02/2019"),
                         Notification(content: "Cảm thấy hài lòng về thái độ tận tâm, tận lực khám chữa bệnh của các bác sỹ ở bệnh viện TW Cảm thấy hài lòng về thái độ tận tâm ...", coverUrl: "https://thumbor.forbes.com/thumbor/960x0/https%3A%2F%2Fspecials-images.forbesimg.com%2Fdam%2Fimageserve%2F42977075%2F960x0.jpg%3Ffit%3Dscale", readStatus: true, publishedAt: "22/02/2019"),
                         Notification(content: "Cảm thấy hài lòng về thái độ tận tâm, tận lực khám chữa bệnh của các bác sỹ ở bệnh viện TW Cảm thấy hài lòng về thái độ tận tâm ...", coverUrl: "https://thumbor.forbes.com/thumbor/960x0/https%3A%2F%2Fspecials-images.forbesimg.com%2Fdam%2Fimageserve%2F42977075%2F960x0.jpg%3Ffit%3Dscale", readStatus: true, publishedAt: "21/02/2019")]
    }
}
