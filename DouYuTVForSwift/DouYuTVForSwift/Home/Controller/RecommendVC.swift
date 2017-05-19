//
//  RecommendVC.swift
//  DouYuTVForSwift
//
//  Created by t4 on 17/4/24.
//  Copyright © 2017年 t4. All rights reserved.
//
//推荐控制器
import UIKit

///间距
fileprivate let kScreenMargin : CGFloat = 10
///宽度
fileprivate let kItemWidth : CGFloat = (kMainWidth-3*kScreenMargin)/2
///正常cell高度
fileprivate let kNormalItemHeight : CGFloat = kItemWidth*3/4
///颜值cell高度
fileprivate let kPrettyItemHeight : CGFloat = kItemWidth*4/3
///轮播图高度
fileprivate let kCycleViewHeight : CGFloat = kMainWidth * 3 / 8

fileprivate let cellID : String = "normalCell"
fileprivate let prettyCellID : String = "prettyCell"
fileprivate let collectionHeaderID : String = "Header"

class RecommendVC: UIViewController {

      //MARK: - 懒加载
     //创建ViewModel的属性
     lazy  var recommandVM : RecommendVM = RecommendVM()
    
     //创建轮播图
     fileprivate lazy var cycleView : RecommendCycleView = {
    
        let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewHeight+90), width: kMainWidth, height: kCycleViewHeight)
        return cycleView
    
    }()
    
    fileprivate lazy var gameView : RecommendGameView = {
    
       let gameView = RecommendGameView.recommendGameView()
        
        gameView.frame = CGRect(x: 0, y: -90, width: kMainWidth, height: 90)
        
        return gameView
        
    }()
    
    //collectionView
    fileprivate lazy var  collectionView:UICollectionView = {[unowned self] in
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
        
        view.backgroundColor = UIColor.orange;
        ///设置UI
        setUpUI()
       //发送网络请求
        loadData()
    }
    
    //MARK: - 请求网络数据
    fileprivate  func loadData(){
     //加载推荐直播数据
        recommandVM.requestData {
            //1.刷新collectionView
            self.collectionView .reloadData()
            //2.给gameView设置数据
            self.gameView.groups = self.recommandVM.anchorGroups
        }
     //加载无限轮播数据
        recommandVM.requestCycleData {
        self.cycleView.cycles = self.recommandVM.cycles
        }
    }
}

//MARK: - 设置UI界面
extension RecommendVC {

    fileprivate func setUpUI() {
    
        view.addSubview(collectionView);
        
        collectionView.addSubview(cycleView)
        
        collectionView.addSubview(gameView)
        
        //设置collectionView内边距
        collectionView.contentInset = UIEdgeInsetsMake(kCycleViewHeight+90, 0, 0, 0)
    
    }
}

//MARK: - UICollectionViewDataSource  UICollectionViewDelegateFlowLayout
extension RecommendVC : UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return recommandVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let group =  recommandVM.anchorGroups[section] as AnchorGroupModel

        return group.anchors.count
    }
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.取出模型数据
        let group  = recommandVM.anchorGroups[indexPath.section]
        
        let anchor = group.anchors[indexPath.item]
        
        //2.定义cell
        var  cell : CollectionViewBaseCell
        
        if indexPath.section == 1 {
            
          cell = collectionView.dequeueReusableCell(withReuseIdentifier: prettyCellID, for: indexPath) as! CollectionPrettyCell
            
        }else {
        
          cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CollectionNormalCell
        }
         cell.anchor = anchor
         return cell
    }
  
    //返回组头的view
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView =  collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: collectionHeaderID, for: indexPath) as! CollectionHeaderView
        headerView.backgroundColor = UIColor.white
        
        headerView.anchorGroup = recommandVM.anchorGroups[indexPath.section]
        
        return headerView
    }
    
    // UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
    
        if indexPath.section == 1 {
            
            return CGSize(width: kItemWidth, height: kPrettyItemHeight)
        }else {
            
            return CGSize(width: kItemWidth, height: kNormalItemHeight)
        }
    }
}
