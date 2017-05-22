//
//  GameViewController.swift
//  DouYuTVForSwift
//
//  Created by t4 on 17/5/19.
//  Copyright © 2017年 t4. All rights reserved.
//

import UIKit
///cell周边间距
fileprivate let kEdgeMargin :CGFloat  = 10
///cell宽度
fileprivate let kGameItemWidth = (kMainWidth-2*kEdgeMargin)/3
///cell高度
fileprivate let kGameItemHeight = kItemWidth*6/5

fileprivate let kGameVCCell  = "kGameVCCell"

fileprivate let kGameHeader = "kGameHeader"

class GameViewController: UIViewController {
    
    
    //MARK: - 懒加载属性
    fileprivate lazy var collectionView : UICollectionView = {
    
    let layOut  = UICollectionViewFlowLayout()
        layOut.itemSize = CGSize(width: kGameItemWidth, height: kGameItemHeight)
        layOut.minimumLineSpacing = 0
        layOut.minimumInteritemSpacing = 0
        layOut.sectionInset = UIEdgeInsets(top: 0, left: kEdgeMargin, bottom: 0, right: kEdgeMargin)
        //设置组头
        layOut.headerReferenceSize = CGSize(width: kMainWidth, height: 35)
    
    let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layOut)
        collectionView.delegate = self
        collectionView.dataSource = self
        //由于控制器view的frame随着父控件拉伸 所以子控件collectionView也需要设置拉伸
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        collectionView.register(UINib(nibName: "GameHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kGameHeader)
        collectionView.register(UINib(nibName: "GameCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kGameVCCell)
        collectionView.backgroundColor = UIColor.white

    return collectionView
    }()
    
    ///数据类型
    fileprivate lazy var gameViewModel :GameViewModel = GameViewModel()

    fileprivate lazy var gameHeaderView : GameHeaderView = {
    
    let gameView = GameHeaderView.shardGameHeaderView()
    
        gameView.frame =  CGRect(x: 0, y: -120, width: kMainWidth, height: 35)
        gameView.titleTextLabel.text = "常用"
        gameView.autoresizingMask = .init(rawValue: 0)
      return gameView
    }()
    
    fileprivate lazy var recommendGameView : RecommendGameView = {
    
        let  recommendGameView = RecommendGameView.recommendGameView()
        recommendGameView.frame = CGRect(x: 0, y: -85, width: kMainWidth, height: 85)
        return recommendGameView
    }()
    
    
    //MARK: - 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
    
        setUpUI()
        
        loadData()
        
      }
    
}

//MARK: - 控制器方法
extension GameViewController {

    //设置UI
    fileprivate func setUpUI() {
        
     view.addSubview(collectionView)
    
    collectionView.addSubview(gameHeaderView)
    
    collectionView.addSubview(recommendGameView)
        
    collectionView.contentInset = UIEdgeInsets(top: 120, left: 0, bottom: 0, right: 0)
    
    }
  
    //获取数据
    fileprivate func loadData(){
      
        gameViewModel.loadAllGameData {
            //1.得到数据后刷新collectionView
            self.collectionView.reloadData()
             //取出前十个model
            let gameGroups = Array(self.gameViewModel.games[0..<10])
            self.recommendGameView.groups = gameGroups
            
        }
    }

}


extension GameViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return gameViewModel.games.count
    }
  
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameVCCell, for: indexPath) as! GameCollectionViewCell
        cell.group = gameViewModel.games[indexPath.item]
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kGameHeader, for: indexPath) as! GameHeaderView
        return headerView
    }
    
}
