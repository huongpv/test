//
//  FontVC.swift
//  Test
//
//  Created by Macbook on 3/10/19.
//  Copyright © 2019 huongpv. All rights reserved.
//

import UIKit

class FontVC: UITableViewController {
    var fonts = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.setup(input: self)
        tableView.registerNibCellFor(type: FontCell.self)
        
        fonts = ["Pacifico", "Sofia-Regular"]
        
        setViewBackgroundColorBy(imageNamed: "login-mohini")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fonts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let fontName = fonts[indexPath.row]
        let cell = tableView.reusableCell(type: FontCell.self)!
        cell.setupView(fontName: fontName)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let fontName = fonts[indexPath.row]
        SharedData.fontName = fontName
        
        let tabbarVC = TabbarVC()
        SystemBoots.instance.appDelegate?.changeRootViewControoler(viewController: tabbarVC)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
