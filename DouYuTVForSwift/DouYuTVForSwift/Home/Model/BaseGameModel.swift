//
//  BaseGameModel.swift
//  DouYuTVForSwift
//
//  Created by t4 on 17/5/19.
//  Copyright © 2017年 t4. All rights reserved.
//

import UIKit

class BaseGameModel: NSObject {

    var tag_name : String?
    
    var icon_url : String?
    
    override  init() {
        super.init()
    }

    
    init(dict:[String:NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    

}
