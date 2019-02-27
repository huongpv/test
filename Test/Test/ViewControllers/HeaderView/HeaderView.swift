//
//  HeaderView.swift
//  Test
//
//  Created by huongpv on 2/27/19.
//  Copyright © 2019 huongpv. All rights reserved.
//

import UIKit

class HeaderView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var imgProfiles: UIImageView!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnRegister: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("HeaderView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        setupView()
    }
    
    private func setupView() {
        // imgProfiles
        let shapeLayer = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: imgProfiles.frame.width / 2, y: imgProfiles.frame.width / 2), radius: imgProfiles.frame.height / 2, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 0.7
        shapeLayer.fillColor = UIColor.clear.cgColor
        imgProfiles.layer.addSublayer(shapeLayer)
        
        let shapeLayer2 = CAShapeLayer()
        let circularPath2 = UIBezierPath(arcCenter: CGPoint(x: imgProfiles.frame.width / 2, y: imgProfiles.frame.width / 2), radius: imgProfiles.frame.height / 2 + 5, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        shapeLayer2.path = circularPath2.cgPath
        shapeLayer2.strokeColor = UIColor.white.cgColor
        shapeLayer2.lineWidth = 0.5
        shapeLayer2.fillColor = UIColor.clear.cgColor
        imgProfiles.layer.addSublayer(shapeLayer2)
        
        let shapeLayer3 = CAShapeLayer()
        let circularPath3 = UIBezierPath(arcCenter: CGPoint(x: imgProfiles.frame.width / 2, y: imgProfiles.frame.width / 2), radius: imgProfiles.frame.height / 2 + 12, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        shapeLayer3.path = circularPath3.cgPath
        shapeLayer3.strokeColor = UIColor.white.cgColor
        shapeLayer3.lineWidth = 0.5
        shapeLayer3.fillColor = UIColor.clear.cgColor
        imgProfiles.layer.addSublayer(shapeLayer3)
        
        // btnLogin
        btnLogin.setGradientLayer(startColor: .green, endColor: .blue, gradientDirection: .leftToRight, radius: 20)
        
        // btnRegister
        btnRegister.setCorner(20)
        btnRegister.setGradientBackground(startColor: .green, endColor: .blue, gradientDirection: .leftToRight)
    }

}
