//
//  MyPageVC.swift
//  Test
//
//  Created by huongpv on 12/24/18.
//  Copyright © 2018 huongpv. All rights reserved.
//

import UIKit

class MyPageVC: UITableViewController {
    
    var arrStr = ["Thay đổi nền", "Thay đổi font chữ"]
    
    // MARK: -Private
    private let myPagePresenter = MyPagePresenter(diaryService: DiaryService())
    private let user = CoreDataManager.shared.getDataFromDB(type: UserDB.self).last

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.setGradientBackgroundNav(startColor: #colorLiteral(red: 0.09803921569, green: 0.568627451, blue: 0.9215686275, alpha: 1), endColor: #colorLiteral(red: 0.1764705882, green: 0.631372549, blue: 0.9725490196, alpha: 1), gradientDirection: .leftToRight)
        
        navigationItem.title = "Cài đặt"
        
        myPagePresenter.attachViewController(self)
        
        setupTableView()
        
        setViewBackgroundColorBy()
    }
    
    private func setupTableView() {
        tableView.setup(input: self)
        tableView.registerNibCellFor(type: MyPageCell.self)
        
        // headerView
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 200)
        let headerView = HeaderView(frame: frame)
        if let user = user {
            headerView.updateView(user: user)
        }
        
        tableView.tableHeaderView = headerView
        
        // footerView
        let footerFrame = CGRect(x: 0, y: 20, width: view.frame.width, height: 37)
        let footerView = FooterView(frame: footerFrame)
        footerView.myPagePresenter = myPagePresenter
        tableView.tableFooterView = footerView
        
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrStr.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let str = arrStr[indexPath.row]
        let cell = tableView.reusableCell(type: MyPageCell.self)!
        cell.setupView(str: str)
        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let backgroundVC = BackGroundImageVC(collectionViewLayout: UICollectionViewLayout())
            VCService.push(controller: backgroundVC)
        } else {
            let fontVC = FontVC()
            VCService.push(controller: fontVC)
        }
        
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
