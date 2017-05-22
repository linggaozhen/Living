//
//  CycleModel.swift
//  LivingApplication
//
//  Created by ioser on 17/5/21.
//  Copyright © 2017年 ioser. All rights reserved.
//

import UIKit

class CycleModel: NSObject {

    var id : Int = 0
    var title : String = ""
    var pic_url : String = ""
    var tv_pic_url : String = ""
    var roomArray : [RoomListModel] = [RoomListModel]()
    
    var room : [String : AnyObject]? {
        didSet{
            guard let trurRoom = room else {return}
            let roomModel = RoomListModel(dic: trurRoom)
            roomArray.append(roomModel)
        }
    }
    
    init(dic : [String : AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dic)
    }
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}
