//
//  AmuseMenuViewCell.swift
//  DYZB
//
//  Created by 1 on 16/10/11.
//  Copyright © 2016年 小码哥. All rights reserved.
//

import UIKit

private let kGameCellID = "kGameCellID"

class AmuseMenuViewCell: UICollectionViewCell {
    
    
    // MARK: 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    var groups : [AnchorGroupModel]?{
    
        didSet {
            
            self.collectionView.reloadData()
        
        }
    
    }
    // MARK: 从Xib中加载
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib(nibName: "GameCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemW = collectionView.bounds.width / 3
        let itemH = collectionView.bounds.height / 2
        layout.itemSize = CGSize(width: itemW, height: itemH)
    }
}


extension AmuseMenuViewCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.求出Cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! GameCollectionViewCell
        
        // 2.给Cell设置数据
       cell.group = groups?[indexPath.item]
        
        return cell
    }
    
    
       
    
}
