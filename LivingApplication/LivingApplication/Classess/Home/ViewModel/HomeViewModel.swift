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
    
    
}

extension HomeViewModel{
    
    // 轮播图的数据请求
    class func loadCycleData(CallBack : (responeArray : [CycleModel]) ->()){
        
        var cycleArray : [CycleModel] = [CycleModel]()
        
        
        NetworkTool.netWorkToolRequestData(.GetMethod, URL: "http://www.douyutv.com/api/v1/slide/6?version=2.4.9.1") { (responeValue) in
            guard let dicValue = responeValue as? [String : AnyObject] else {return}
            guard let ArrayData = dicValue["data"] as? [[String : AnyObject]] else {return}
            for dictionary in ArrayData {
                let cycleModel = CycleModel(dic: dictionary)
                cycleArray.append(cycleModel)
//                print(cycleModel.pic_url)
            }
            CallBack(responeArray: cycleArray)
        }
        
    }
    
    // 首页推荐模块的数据请求
    class func loadRecommerData(finishCallBack : (modelArray : [AnchorGorup]) -> ()){
        
        
        let nowInterval = NSDate.timeSince1970()
        var groupArray : [AnchorGorup] = [AnchorGorup]()
        
        
        //最热
        let hottestGroupModel : AnchorGorup = AnchorGorup()
        hottestGroupModel.tag_name = "最热"
        hottestGroupModel.icon_url = ""
        // 颜值
        let prettyGroupModel : AnchorGorup = AnchorGorup()
        prettyGroupModel.tag_name = "颜值"
        prettyGroupModel.icon_url = "home_header_normal"
        
        let DGroup = dispatch_group_create()
        
        
        
        // 请求推荐模块的第一部分数据
        dispatch_group_enter(DGroup)
        NetworkTool.netWorkToolRequestData(.GetMethod, URL: "http://capi.douyucdn.cn/api/v1/getbigDataRoom?time=\(nowInterval)") { (responeValue) in
            guard let dicvalue = responeValue as? [String : AnyObject] else {return}
            guard let dataArray = dicvalue["data"] as? [[String : AnyObject]] else {return}
            for dictionary in dataArray {
                let RecommmerFirstModel = RoomListModel.init(dic: dictionary)
                hottestGroupModel.arrayForRoomListModel.append(RecommmerFirstModel)
            }
            dispatch_group_leave(DGroup)
        }
        
        // 请求推荐模块第二部分数据
        dispatch_group_enter(DGroup)
        NetworkTool.netWorkToolRequestData(.GetMethod, URL: "http://capi.douyucdn.cn/api/v1/getVerticalRoom?limit=4&offset=0&time=\(nowInterval)") { (responeValue) in
            guard let dicValue = responeValue as? [String : AnyObject] else {return}
            guard let dataArray = dicValue["data"] as? [[String : AnyObject]] else {return}
            for dictionary in dataArray {
                let model = RoomListModel.init(dic: dictionary)
                // 把RoomList模型保存到AnchorGroup中
                prettyGroupModel.arrayForRoomListModel.append(model)
            }
            dispatch_group_leave(DGroup)
        }
        
        // 请求推荐模块第三部分数据
        dispatch_group_enter(DGroup)
        NetworkTool.netWorkToolRequestData(.GetMethod, URL: "http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=\(nowInterval)") { (responeValue) in
            
            guard let responeDic = responeValue as? [String : AnyObject] else {return}
            
            guard let dataArray = responeDic["data"] as? [[String : AnyObject]] else {return}
            for dictionary in dataArray {
                // 每组数据模型
                let groupModel = AnchorGorup.init(dic: dictionary)
                groupArray.append(groupModel)
            }
            dispatch_group_leave(DGroup)
        }
        
        // 所有数据请求后，进行排序
        dispatch_group_notify(DGroup, dispatch_get_main_queue()) { 
            groupArray.insert(prettyGroupModel, atIndex: 0)
            groupArray.insert(hottestGroupModel, atIndex: 0)
            finishCallBack(modelArray: groupArray)
        }
        
        
    }

}

// MARK: - 首页游戏数据的请求
extension HomeViewModel {
    
    class func loadGameData(finishCallBack : (modelArray : [GameModel]) ->())  {
        var gModelArray : [GameModel] = [GameModel]()
        NetworkTool.netWorkToolRequestData(.GetMethod, URL: "http://capi.douyucdn.cn/api/v1/getColumnDetail?shortName=game") { (responeValue) in
            guard let dicValue = responeValue as? [String : AnyObject] else {return}
            guard let dataArray = dicValue["data"] as? [[String : AnyObject]] else {return}
            for dictionary in dataArray {
                let gmodel = GameModel.init(dic: dictionary)
                gModelArray.append(gmodel)
            }
            
            finishCallBack(modelArray: gModelArray)
        }
    }
}


