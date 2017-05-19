//
//  AnchorGroupModel.swift
//  DouYuTVForSwift
//
//  Created by t4 on 17/5/17.
//  Copyright © 2017年 t4. All rights reserved.
//

import UIKit
//组model
class AnchorGroupModel: NSObject {
   
    //该组的房间信息
    var room_list : [[String : NSObject]]?{
    
        //当对room_list 赋值时候 便利  转化为model
        didSet{
            guard let room_list = room_list else {
                
               return
            }
            //便利 组里 所有房间的数据 转化为model 添加到数组中
            for dic  in room_list {
            
                let model = AnchorModel(dict: dic)
                anchors.append(model);
            }
        }
    }
    
    var push_vertical_screen  : String?
    //该组的图标
    var icon_url : String?
    var icon_name : String?
    //该组的标题
    var tag_name : String?
    //存放四个房间model 的数组
    var anchors:[AnchorModel] = [AnchorModel]()

   
    
    
   override  init() {
        super.init()
    }
    
    init(dict:[String:NSObject]) {
        
        super.init()
        setValuesForKeys(dict)
    }
    
    //属性没写全 避免奔溃
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
    }
}
