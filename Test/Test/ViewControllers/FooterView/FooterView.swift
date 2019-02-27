//
//  FooterView.swift
//  Test
//
//  Created by huongpv on 2/27/19.
//  Copyright © 2019 huongpv. All rights reserved.
//

import UIKit

class FooterView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var btnLogout: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("FooterView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        setupView()
    }
    
    private func setupView() {
        btnLogout.set(cornerRadius: 10, borderWidth: 0.5, borderColor: .white)
    }

}
