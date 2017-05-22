//
//  AmuseVC.swift
//  DouYuTVForSwift
//
//  Created by t4 on 17/5/22.
//  Copyright © 2017年 t4. All rights reserved.
//

import UIKit


fileprivate let kMenuViewHeight : CGFloat = 200

class AmuseVC: BaseAnchorViewController {


    fileprivate lazy var amuseVM : AmuseVM = AmuseVM()
    
    fileprivate lazy var amuseMenuView : AmuseMenuView = {
        let menuView = AmuseMenuView.amuseMenuView()
            menuView.frame = CGRect(x: 0, y: -kMenuViewHeight, width: kMainWidth, height: kMenuViewHeight)
           menuView.backgroundColor = UIColor.white
       return menuView
    }()
}







extension AmuseVC {
    
    
    //加载界面
    override func loadUI() {
        super.loadUI()
        
        //添加菜单View
        collectionView.addSubview(amuseMenuView)
        
        collectionView.contentInset = UIEdgeInsets(top: kMenuViewHeight, left: 0, bottom: 0, right: 0)
    
    }
    
    
    //加载数据
    override func loadData () {
       
        super.loadData()
        //1.将数据model赋值父类
        baseAnchorVm = amuseVM
    
        amuseVM.loadAmuseAllData {
            
            self.collectionView.reloadData()
            self.amuseMenuView.groups = self.amuseVM.anchorGroups
        }
    
    }
}


