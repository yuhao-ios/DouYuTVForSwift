//
//  RecommendGameView.swift
//  DouYuTVForSwift
//
//  Created by t4 on 17/5/18.
//  Copyright © 2017年 t4. All rights reserved.
//

import UIKit


fileprivate let kRecommendGameCell = "kGameCell"

class RecommendGameView: UIView {

    //MARK: -  控件属性
    @IBOutlet weak var collectionView: UICollectionView!

    var groups :[BaseGameModel]?{
    
        didSet{
        
            //2.刷新collectionView
            collectionView.reloadData()
        }

    }
    
    
    
    //MARK: - xib加载完成
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = .init(rawValue: 0)//让视图不随着父控件拉伸而拉伸  去掉这句后会看不到控件
        
        collectionView.register(UINib.init(nibName: "GameCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kRecommendGameCell)
    }
    
    override func layoutSubviews() {
        
      super.layoutSubviews()
        
      let layOut =   collectionView.collectionViewLayout as! UICollectionViewFlowLayout
       layOut.itemSize = CGSize(width: kMainWidth/4, height: self.frame.height)
       layOut.minimumLineSpacing = 0
       layOut.minimumInteritemSpacing = 0
       layOut.scrollDirection = .horizontal
       collectionView.showsHorizontalScrollIndicator = false
       collectionView.isPagingEnabled = true
    }
}

 //MARK: - 初始化
extension RecommendGameView {

    class  func recommendGameView() -> RecommendGameView{

        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)!.first  as! RecommendGameView
    }
    
}

//MARK: - 代理相关
extension RecommendGameView : UICollectionViewDataSource,UICollectionViewDelegate{

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: kRecommendGameCell, for: indexPath) as! GameCollectionViewCell
        cell.group = groups?[indexPath.item]
      return cell
    }

}
