//
//  FunnyViewController.swift
//  DouYuTVForSwift
//
//  Created by t4 on 17/5/22.
//  Copyright © 2017年 t4. All rights reserved.
//

import UIKit

class FunnyViewController: BaseAnchorViewController {

    fileprivate lazy var funnyVM :  FunnyVM = FunnyVM()
}


extension FunnyViewController {

    override func loadUI() {
        super.loadUI()
        //重新设置布局
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        collectionView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
    }
    
    override func loadData() {
        super.loadData()
   
        //获取数据
        funnyVM.loadFunnyAllData{
            //1.给父类model 赋值
            self.baseAnchorVm = self.funnyVM
            //2.刷新界面
            self.collectionView.reloadData()
        }
    }

}
