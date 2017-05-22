//
//  UIColor+Extension.swift
//  DouYuTVForSwift
//
//  Created by t4 on 17/4/17.
//  Copyright © 2017年 t4. All rights reserved.
//

import UIKit


extension  UIColor {

    convenience init(r:CGFloat,g:CGFloat,b:CGFloat,alpha:CGFloat) {
        
      self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: alpha)
    
    }

    
     class func randomColor() -> UIColor {
    
     return UIColor(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)), alpha: 1.0)
    }

}
