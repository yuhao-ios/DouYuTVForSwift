//
//  CycleViewModel.swift
//  DouYuTVForSwift
//
//  Created by t4 on 17/5/18.
//  Copyright © 2017年 t4. All rights reserved.
//

import UIKit

class CycleViewModel: NSObject {

    var title : String?
    var pic_url : String?
    var tv_pic_url : String?
    //主播房间的数据
    var room  : [String :NSObject]? {
        didSet {
        
            guard let room = room else {
                return
            }
            //转化为model
            anchor = AnchorModel(dict: room)
        }
    
    }
    //主播房间的model
    var anchor : AnchorModel?
    
    init(dict:[String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}
