//
//  NetworkTools.swift
//  DouYuTVForSwift
//
//  Created by t4 on 17/5/10.
//  Copyright © 2017年 t4. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
  case GET
  case POST
}

class NetworkTools: NSObject {
    
    //网络请求
    class func requestData(type : MethodType,url:String,parameters:[String :Any]?=nil,finishedCallBack : @escaping (_ respone:AnyObject) ->  ()) {
        
        //获取类型
        let methodType = type == .GET ? HTTPMethod.get : HTTPMethod.post
    
        //发送网络请求
        
        Alamofire.request(url, method: methodType, parameters: parameters).responseJSON { (respone) in
            //获取结果
            guard let result = respone.result.value else {
            
                print(respone.result.error ?? "暂无数据")
             return
            }
            //把结果回调出去
            finishedCallBack(result as AnyObject)
        }
       /* Alamofire.request(url,method:methodType,parameters:parameters).responseJSON { (respone) in
            //获取结果
            guard let result = respone.result.value else {
    
                return
            }
 
            //把结果回调出去
            finishedCallBack(result as AnyObject)
        }
        */
    }
    


}
