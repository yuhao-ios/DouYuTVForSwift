//
//  RecommendVC.swift
//  DouYuTVForSwift
//
//  Created by t4 on 17/4/24.
//  Copyright © 2017年 t4. All rights reserved.
//
//推荐控制器
import UIKit

class RecommendVC: BaseAnchorViewController {

      //MARK: - 懒加载
     //创建ViewModel的属性
     lazy  var recommandVM : RecommendVM = RecommendVM()
    
     //创建轮播图
     fileprivate lazy var cycleView : RecommendCycleView = {
    
        let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewHeight+90), width: kMainWidth, height: kCycleViewHeight)
        return cycleView
    
    }()
    
    //创建显示游戏名字的视图
    fileprivate lazy var gameView : RecommendGameView = {
    
       let gameView = RecommendGameView.recommendGameView()
        
        gameView.frame = CGRect(x: 0, y: -90, width: kMainWidth, height: 90)
        
        return gameView
    }()
    
}

//MARK: - 设置UI界面
extension RecommendVC {

    //重写父类的布局
    override func loadUI() {
  
        super.loadUI()
        
        collectionView.addSubview(cycleView)
        
        collectionView.addSubview(gameView)

        //设置collectionView内边距
        collectionView.contentInset = UIEdgeInsetsMake(kCycleViewHeight + 90, 0, 0, 0)
    
    }

    // 重写父类 请求网络数据 的方法
    override  func loadData(){
        
        super.loadData()
        
        //给父类赋值
        baseAnchorVm = recommandVM
        //加载推荐直播数据
        recommandVM.requestData {
            //1.刷新collectionView
            self.collectionView .reloadData()
            
            //2.
            var groups = self.recommandVM.anchorGroups
            //2.1.移除前两组数据  添加一组更多数据
            groups.remove(at: 0)
            groups.remove(at: 0)
            let moreGroup = AnchorGroupModel()
            moreGroup.tag_name = "更多"
            groups.append(moreGroup)
            
            //2.2给gameView设置数据
            self.gameView.groups = groups
            //3.数据加载完成 展示内容
            self.showContentView()
        }
        //加载无限轮播数据
        recommandVM.requestCycleData {
            
            self.cycleView.cycles = self.recommandVM.cycles
        }

    }
}

//MARK: - UICollectionViewDataSource  UICollectionViewDelegateFlowLayout
extension RecommendVC : UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 1 {
            return CGSize(width: kItemWidth, height: kPrettyItemHeight)
        }
        
        return CGSize(width: kItemWidth, height: kNormalItemHeight)
    }

    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //section = 1 返回自己的cell
        if indexPath.section == 1 {
           
            let prettyCell = collectionView.dequeueReusableCell(withReuseIdentifier:prettyCellID , for: indexPath) as! CollectionPrettyCell
            
            // 2.设置数据
            prettyCell.anchor = recommandVM.anchorGroups[indexPath.section].anchors[indexPath.item]

            return prettyCell
        }
        
        //否则返回父类的cell
        return  super.collectionView(collectionView, cellForItemAt: indexPath)
    }
}
