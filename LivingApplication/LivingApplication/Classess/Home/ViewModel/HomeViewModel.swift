//
//  HomeViewModel.swift
//  LivingApplication
//
//  Created by ioser on 17/5/19.
//  Copyright © 2017年 ioser. All rights reserved.
//

//let parameters = ["limit" : "4", "offset" : "0", "time" : Date.getCurrentTime()]
// "http://capi.douyucdn.cn/api/v1/getHotCate"


//------------------首页模块ViewModel------------------------

import UIKit


class HomeViewModel: NSObject {

    // 首页推荐模块的数据请求
    class func loadRecommerData(){
        
        let nowInterval = Int(NSDate().timeIntervalSince1970)
//        print(nowInterval)
//        let dic = ["limit" : "4", "offset" : "0", "time" : "\(nowInterval)"]
//        NetworkTool.netWorkToolRequestData(.GetMethod, URL: "http://capi.douyucdn.cn/api/v1/getHotCate", parameter: dic) { (responeValue) in
//            print(responeValue)
//        }
        NetworkTool.netWorkToolRequestData(.GetMethod, URL: "http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=\(nowInterval)") { (responeValue) in
            guard let responeDic = responeValue as? [String : AnyObject] else {return}
            
            guard let dataArray = responeDic["data"] as? [[String : AnyObject]] else {return}
            for i in 0..<dataArray.count {
                let dic = dataArray[i]
                let groupModel = AnchorGorup.init(dic: dic)
                let listModel : RoomListModel = groupModel.arrayForRoomListModel[0]
                print(" \(listModel.room_name)")
            }
        }
    }
    
}
