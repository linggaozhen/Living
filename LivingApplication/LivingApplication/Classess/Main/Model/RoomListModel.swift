//
//  RoomListModel.swift
//  LivingApplication
//
//  Created by ioser on 17/5/19.
//  Copyright © 2017年 ioser. All rights reserved.
//

import UIKit

class RoomListModel: NSObject {

    var specific_catalog : String = ""
    var owner_uid : Int = 0
    var vertical_src : String = ""
    var room_src : String = ""
    var avatar_small : String = ""
    var avatar_mid : String = ""
    var online : Int = 0
    var room_id : Int = 0
    var nickname : String = ""
    var game_name : String = ""
    var room_name : String = ""
    var anchor_city : String = ""
    
    
    convenience init(dic : [String : AnyObject]) {
        self.init()
        setValuesForKeysWithDictionary(dic)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
}
