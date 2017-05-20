//
//  NSDate+Extension.swift
//  LivingApplication
//
//  Created by ioser on 17/5/20.
//  Copyright © 2017年 ioser. All rights reserved.
//

import UIKit

extension NSDate {
    class func timeSince1970() -> String {
        let time = Int(NSDate().timeIntervalSince1970)
        return "\(time)"
    }
}
