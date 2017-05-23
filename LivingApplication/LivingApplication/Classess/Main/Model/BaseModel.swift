//
//  BaseModel.swift
//  LivingApplication
//
//  Created by ioser on 17/5/23.
//  Copyright © 2017年 ioser. All rights reserved.
//

import UIKit

class BaseModel: NSObject {
    var tag_name : String = ""
    var icon_url : String = ""
    init(dic : [String : AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dic)
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}
