//
//  UIBarButtonItem+Extension.swift
//  DouYuTVForSwift
//
//  Created by t4 on 17/4/14.
//  Copyright © 2017年 t4. All rights reserved.
//

import UIKit


extension UIBarButtonItem {

    //MARK: - 创建类方法 添加导航栏按钮item
   /* class func  cgreateItem(imageName:String, heightImageName:String?,size:CGSize?) -> UIBarButtonItem{
    
        //1.1.创建按钮  给按钮设置图片
        let btn = UIButton()
        btn.setImage(UIImage(named:imageName), for: .normal)
        
        //1.2设置按钮高亮图片
        if let clickImageName = heightImageName {
            btn.setImage(UIImage(named:clickImageName), for: UIControlState.highlighted)
        }
        //1.3设置按钮frame
        if let frameSize = size {
            
            btn.frame = CGRect(origin: CGPoint.zero, size: frameSize)
        }else{
            btn.sizeToFit()//根据图片自适应尺寸大小
        }
        
        let item = UIBarButtonItem(customView: btn)
        
        return item
    }*/
 
    
    
    //MARK: 使用构造函数 添加导航栏按钮item
    //便利构造函数:1>必须convenience开头 2》 在构造函数中必须明确一个设计的构造函数（self）
   convenience  init(imageName:String, heightImageName:String?,size:CGSize?) {
        
    //1.1.创建按钮  给按钮设置图片
    let btn = UIButton()
    btn.setImage(UIImage(named:imageName), for: .normal)
    
    //1.2设置按钮高亮图片
    if let clickImageName = heightImageName {
        btn.setImage(UIImage(named:clickImageName), for: UIControlState.highlighted)
    }
    //1.3设置按钮frame
    if let frameSize = size {
        
        btn.frame = CGRect(origin: CGPoint.zero, size: frameSize)
    }else{
        btn.sizeToFit()//根据图片自适应尺寸大小
    }
    
     self.init(customView:btn)
    
    }

}
