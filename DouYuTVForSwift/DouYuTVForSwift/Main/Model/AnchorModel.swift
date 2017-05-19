//
//  AnchorModel.swift
//  DouYuTVForSwift
//
//  Created by t4 on 17/5/17.
//  Copyright © 2017年 t4. All rights reserved.
//

import UIKit

//组中的房间model
class AnchorModel: NSObject {

    //主播昵称
    var nickname : String?
     //主播ID
    var owner_uid : Int?
    //房间图片的urlString
    var vertical_src : String?
    //在线人数
    var online : NSNumber?
    //房间名称
    var room_name : String?
    //房间ID
    var room_id : Int?
    //直播方式 0 电脑直播  1 手机直播
    var isVertical : Int?
    //主播所在地区
    var anchor_city : String?
    
    init(dict : [String : NSObject] ) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
