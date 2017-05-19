//
//  NSDate+Extension.swift
//  DouYuTVForSwift
//
//  Created by t4 on 17/5/10.
//  Copyright © 2017年 t4. All rights reserved.
//

import Foundation

extension NSDate {

    //获取当前时间的字符串
    class func getCurrentTime()->String {
        
        let nowDate = NSDate()
        let interVal  = nowDate.timeIntervalSince1970
        print("\(interVal)")
        return "\(interVal)"
    }



}
