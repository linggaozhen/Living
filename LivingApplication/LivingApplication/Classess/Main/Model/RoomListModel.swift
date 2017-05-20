//
//  RoomListModel.swift
//  LivingApplication
//
//  Created by ioser on 17/5/19.
//  Copyright © 2017年 ioser. All rights reserved.
//

import UIKit

class RoomListModel: NSObject {

    var vertical_src : String = ""
    var nickname : String = ""
    var game_name : String = ""
    var room_name : String = ""
    
    convenience init(dic : [String : AnyObject]) {
        self.init()
        setValuesForKeysWithDictionary(dic)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
}
