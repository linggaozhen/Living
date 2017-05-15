//
//  pageContentView.swift
//  LivingApplication
//
//  Created by ioser on 17/5/15.
//  Copyright © 2017年 ioser. All rights reserved.
//

import UIKit

class pageContentView: UIView{
    
    init(frame: CGRect, childViewController : [UIViewController], parentController : UIViewController) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
