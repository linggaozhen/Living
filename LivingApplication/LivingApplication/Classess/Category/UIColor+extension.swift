//
//  UIColor+extension.swift
//  LivingApplication
//
//  Created by ioser on 17/5/16.
//  Copyright © 2017年 ioser. All rights reserved.
//

import UIKit

extension UIColor{
    convenience init(r : CGFloat, g : CGFloat, b : CGFloat) {
        self.init(red : r / 255.0, green: g / 255.0, blue: b / 255.0,alpha: 1.0)
        
    }
    
    class func randomColor() -> UIColor{
        return UIColor.init(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
    }
}