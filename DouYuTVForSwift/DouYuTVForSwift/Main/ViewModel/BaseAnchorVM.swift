//
//  BaseAnchorVM.swift
//  DouYuTVForSwift
//
//  Created by t4 on 17/5/22.
//  Copyright © 2017年 t4. All rights reserved.
//

import UIKit

class BaseAnchorVM: NSObject {

   //数组
    lazy var anchorGroups : [AnchorGroupModel] = [AnchorGroupModel]()
    
   //数据方法
    func loadAnchorAllData(url:String ,parameters:[String : Any]? = nil ,isGroupData:Bool, finishCallBack:@escaping()->()){
        
        NetworkTools.requestData(type: .GET, url:url,parameters: parameters) { (response) in
            
            //1. 对数据进行处理
            guard let result = response as? [String : Any] else {
                
                return
            }
            
            guard let dataArray = result["data"] as? [[String : Any]] else{
                
                return
            }
            
            
            //2. 判断是否是分组数据
            if isGroupData{
            
            //是分组数据   便利数据转化model
            for dic in dataArray {
                
                let  anchorGroup  = AnchorGroupModel(dict: dic as! [String : NSObject])
                
                self.anchorGroups.append(anchorGroup)
              }
            
            }else {
            
            //不是分组数据
                //2.1创建组
                let group = AnchorGroupModel()
                //2.2 便利dataArray 所有字典
                for dic in dataArray {
                
                   group.anchors.append(AnchorModel(dict: dic as! [String : NSObject]))
                
                }
               //2.3 将group 添加到 anchorGroups中
                
                self.anchorGroups.append(group)
    
            }
            
            
            
            
            finishCallBack()
            
        }
        
        
        
    }

    
    
    
}
