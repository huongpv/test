//
//  UINavigationBar+Extension.swift
//  Test
//
//  Created by Macbook on 2/27/19.
//  Copyright © 2019 huongpv. All rights reserved.
//

import UIKit

extension UINavigationBar {
    
    func setGradientBackgroundNav(startColor: UIColor, endColor: UIColor, gradientDirection: GradientDirection) {
        
        let gradientLayer = GradientLayer(frame: bounds, startColor: startColor, endColor: endColor, direction: .leftToRight)
        
        setBackgroundImage(gradientLayer.createGradientImage(), for: .default)
    }
}
