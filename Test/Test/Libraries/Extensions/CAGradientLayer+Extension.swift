//
//  CAGradientLayer+Extension.swift
//  Test
//
//  Created by Macbook on 2/27/19.
//  Copyright © 2019 huongpv. All rights reserved.
//

import UIKit

extension CAGradientLayer {
    
    func createGradientImage() -> UIImage? {
        
        var image: UIImage? = nil
        UIGraphicsBeginImageContext(bounds.size)
        if let context = UIGraphicsGetCurrentContext() {
            render(in: context)
            image = UIGraphicsGetImageFromCurrentImageContext()
        }
        UIGraphicsEndImageContext()
        return image
    }
    
}
