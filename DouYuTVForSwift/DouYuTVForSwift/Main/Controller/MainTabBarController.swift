//
//  MainTabBarController.swift
//  DouYuTVForSwift
//
//  Created by t4 on 17/4/14.
//  Copyright © 2017年 t4. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        addChildVC(storyName: "Home")
        addChildVC(storyName: "Live")
        addChildVC(storyName: "Concern")
        addChildVC(storyName: "My")
        
        
    }
    
    //MARK: - 添加子控制器
    fileprivate func addChildVC(storyName:String){
    
    
        //1.加载storyBoard文件
        
        let childVC = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!;
        
        
        //2.将控制器作为子控制器
        
        addChildViewController(childVC)


    }
   
}
