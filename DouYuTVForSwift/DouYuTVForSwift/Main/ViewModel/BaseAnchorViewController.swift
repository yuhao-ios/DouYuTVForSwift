//
//  BaseAnchorViewController.swift
//  DouYuTVForSwift
//
//  Created by t4 on 17/5/22.
//  Copyright © 2017年 t4. All rights reserved.
//

import UIKit

/**
 RecommendVC  和  AmuseVC 由于具有统一的布局界面所有抽调一个父类BaseAnchorViewController   如果有不同在自己私有方法中实现
 */


   ///间距
 let kScreenMargin : CGFloat = 10
  ///宽度
 let kItemWidth : CGFloat = (kMainWidth-3*kScreenMargin)/2
   ///正常cell高度
 let kNormalItemHeight : CGFloat = kItemWidth*3/4
  ///颜值cell高度
 let kPrettyItemHeight : CGFloat = kItemWidth*4/3
  ///轮播图高度
 let kCycleViewHeight : CGFloat = kMainWidth * 3 / 8

 let cellID : String = "normalCell"
 let prettyCellID : String = "prettyCell"
 let collectionHeaderID : String = "Header"


class BaseAnchorViewController: UIViewController {
    //MARK: - 懒加载属性
    
     lazy var baseAnchorVm : BaseAnchorVM = BaseAnchorVM()
    
    //collectionView
     lazy var  collectionView:UICollectionView = {[unowned self] in
        //1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemWidth, height: kNormalItemHeight)
        layout.minimumLineSpacing = 1;
        layout.minimumInteritemSpacing = kScreenMargin;
        //设置组头
        layout.headerReferenceSize = CGSize(width: kMainWidth, height: 38)
        //设置cell内边距
        layout.sectionInset = UIEdgeInsets(top: 0, left: kScreenMargin, bottom: 0, right: kScreenMargin)
        
        //2.创建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor =  UIColor.white
        //让视图的高度宽度随着父视图的高度宽度拉伸
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        
        //注册自定义cell
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: cellID)
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: prettyCellID)
        //注册组头
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: collectionHeaderID)
        return collectionView
        }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadUI()
        loadData()
    }
    
}

extension BaseAnchorViewController {
    
    //布局
     func loadUI(){
        
        view.addSubview(collectionView)
        
    }
    //加载数据
     func loadData () {
        
    }
}


//MARK: - 代理
extension BaseAnchorViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return  baseAnchorVm.anchorGroups.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
    
        return baseAnchorVm.anchorGroups[section].anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CollectionNormalCell
        
        let group = baseAnchorVm.anchorGroups[indexPath.section]
        
        let anchor = group.anchors[indexPath.item]
        
        cell.anchor = anchor
        
        // cell.backgroundColor = UIColor.randomColor()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: collectionHeaderID, for: indexPath) as! CollectionHeaderView
        
        headerView.anchorGroup  = baseAnchorVm.anchorGroups[indexPath.section]
        
        return headerView
    }
    
}
