//
//  CollectionHeaderView.swift
//  DouYuTVForSwift
//
//  Created by t4 on 17/5/9.
//  Copyright © 2017年 t4. All rights reserved.
//

import UIKit

import Kingfisher

class CollectionHeaderView: UICollectionReusableView {

    @IBOutlet weak var titleName: UILabel!
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    var anchorGroup : AnchorGroupModel? {
    
        didSet {
        
         self.titleName.text = anchorGroup?.tag_name
        //判断有没有图标的url  有就赋值 没有给默认
         guard let url = anchorGroup?.icon_url else {
                
                self.iconImageView.image = UIImage(named: (anchorGroup?.icon_name)!)
                return
            }
         
            self.iconImageView.kf.setImage(with: URL(string: url))
        }
    
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    
    
    
    
    
}
