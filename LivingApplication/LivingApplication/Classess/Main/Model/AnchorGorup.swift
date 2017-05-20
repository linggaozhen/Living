//
//  AnchorGorup.swift
//  LivingApplication
//
//  Created by ioser on 17/5/19.
//  Copyright © 2017年 ioser. All rights reserved.
//

import UIKit




class AnchorGorup: NSObject {
    var room_list : [[String : AnyObject]]? {
        didSet{
            guard let roomList = room_list else {return}
            for dic in roomList {
                let roomListModel = RoomListModel.init(dic: dic)
                arrayForRoomListModel.append(roomListModel)
            }
        }
    }
    var arrayForRoomListModel : [RoomListModel] = [RoomListModel]()
    
    var icon_url : String = ""
    var tag_name : String = ""
    var tag_id : NSNumber = 0
    var push_nearby : NSNumber = 0
    var push_vertical_screen : NSNumber = 0
    
    convenience init(dic : [String : AnyObject]) {
        self.init()
        self.setValuesForKeysWithDictionary(dic)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}
