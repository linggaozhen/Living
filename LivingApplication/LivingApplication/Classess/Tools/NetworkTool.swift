//
//  NetworkTool.swift
//  LivingApplication
//
//  Created by ioser on 17/5/19.
//  Copyright © 2017年 ioser. All rights reserved.
//

 ///－－－－－－－－－－－－ 网络请求调用这个工具类－－－－－－－－－－－－－－－－－

import UIKit
import Alamofire

enum requestType {
    case GetMethod
    case POSTMethod
}

class NetworkTool: NSObject {
    
    
    // 给外界提供请求接口
    class func netWorkToolRequestData(type : requestType, URL : String, parameter : [String : NSObject]? = nil, finishCallBack : (responeValue : AnyObject) -> Void){
        
        let MethodType = type == .GetMethod ? Method.GET : Method.POST
        Alamofire.request(MethodType, URL, parameters: parameter, encoding: ParameterEncoding.JSON, headers: nil).responseJSON { (responeValue) in
            print(responeValue)
        }
        
    }
}
