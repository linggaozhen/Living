//
//  UIBarButtonItem+extension.swift
//  LivingApplication
//
//  Created by ioser on 17/5/15.
//  Copyright © 2017年 ioser. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
  
    // swift 类方法
//    class func createBarButtonItem(imageName : String, hightImageName : String = "", size : CGSize = CGSizeZero) -> UIBarButtonItem {
//      
//        let btn = UIButton()
//        
//        btn.setImage(UIImage(named: imageName), forState: .Normal)
//        if hightImageName != "" {
//            btn.setImage(UIImage(named: hightImageName), forState: .Highlighted)
//        }
//        
//        if size == CGSizeZero {
//            btn.sizeToFit()
//        } else {
//            btn.frame.size = size
//        }
//        
//        let item = UIBarButtonItem(customView: btn)
//        
//        return item
//    }
    
    convenience init(imageName : String, hightImageName : String = "", size : CGSize = CGSizeZero) {
        let btn = UIButton()
        // 设置图片
        btn.setImage(UIImage(named: imageName), forState: .Normal)
        if hightImageName != "" {
            btn.setImage(UIImage(named: hightImageName), forState: .Highlighted)
        }
        // btn size
        if size == CGSizeZero {
            btn.sizeToFit()
        } else {
          btn.frame.size = size
        }
        
        self.init(customView : btn)
    }
}






