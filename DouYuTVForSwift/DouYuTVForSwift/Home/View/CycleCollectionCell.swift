//
//  CycleCollectionCell.swift
//  DouYuTVForSwift
//
//  Created by t4 on 17/5/18.
//  Copyright © 2017年 t4. All rights reserved.
//

import UIKit
import Kingfisher

class CycleCollectionCell: UICollectionViewCell {

    //MARK: - 控件属性
    @IBOutlet weak var titleTextLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!

    var cycle : CycleViewModel?{
    
        didSet {
            guard let cycle = cycle else {
                return
            }
            self.titleTextLabel.text = cycle.title
            
            self.iconImageView.kf.setImage(with: URL(string: cycle.pic_url!))
        }
    
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

}
