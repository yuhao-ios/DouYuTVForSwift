//
//  AmuseMenuView.swift
//  DouYuTVForSwift
//
//  Created by t4 on 17/5/22.
//  Copyright © 2017年 t4. All rights reserved.
//

import UIKit

fileprivate let AmuseMenuCell = "menuCell"

class AmuseMenuView: UIView {

    //MARK: - 控件属性
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var groups : [AnchorGroupModel]?{

       didSet {
    
           self.collectionView.reloadData()
       }

   }
    //MARK: - 从xib加载完成
    override func awakeFromNib() {
        super.awakeFromNib()
        //让控件不随着父控件拉伸而拉伸
        autoresizingMask = .init(rawValue: 0)
        //注册cell
        collectionView.register(UINib(nibName: "AmuseMenuViewCell", bundle: nil), forCellWithReuseIdentifier: AmuseMenuCell)

    }
    
    // 设置尺寸
    override func  layoutSubviews() {
        super.layoutSubviews()
        
        let layout   = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.itemSize = collectionView.bounds.size
        
        layout.scrollDirection = .horizontal
        
        collectionView.isPagingEnabled = true
        
        collectionView.showsHorizontalScrollIndicator = false
        
    }
    
}


//MARK: - 布局初始化
extension AmuseMenuView {

    
   class func amuseMenuView() -> AmuseMenuView {
    
     return Bundle.main.loadNibNamed("AmuseMenuView", owner: nil, options: nil)?.first as! AmuseMenuView
    }
}

//MARK: - UICollectionViewDataSource
extension AmuseMenuView:UICollectionViewDataSource,UICollectionViewDelegate {


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if groups == nil {
            return 0
        }
        pageControl.numberOfPages = ((groups?.count)!-1)/6+1
        return  ((groups?.count)!-1)/6+1
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AmuseMenuCell , for: indexPath) as! AmuseMenuViewCell
        cell.backgroundColor = UIColor.randomColor()
        // 2.给Cell设置数据
        setupCellDataWithCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    
    fileprivate func setupCellDataWithCell(cell:AmuseMenuViewCell,indexPath :IndexPath){
        
        //0页 0-7
        //1页 8-15
        //2页 16-23
        //1.开始的下标
        let  startIndex  = indexPath.item*6
        var endIndex = (indexPath.item+1)*6-1
        
        //2.判断是否越界
        if endIndex > (groups?.count)!-1 {
            endIndex = (groups?.count)! - 1
        }
        //3.取出数据复制cell
        cell.groups = Array(groups![startIndex...endIndex])
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let ofsetx  =  scrollView.contentOffset.x
        
        pageControl.currentPage = Int(ofsetx/scrollView.bounds.width)
    }
    

}
