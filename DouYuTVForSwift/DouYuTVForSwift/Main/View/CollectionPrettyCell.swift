//
//  CollectionPrettyCell.swift
//  DouYuTVForSwift
//
//  Created by t4 on 17/5/9.
//  Copyright © 2017年 t4. All rights reserved.
//

import UIKit
import Kingfisher
class CollectionPrettyCell: CollectionViewBaseCell {

    //单独不同的控件
    @IBOutlet weak var adressBtn: UIButton!
    
    override  var anchor : AnchorModel?{
        didSet {
        //0.将得到的模型数据赋值给父类
        super.anchor = anchor

         //1.检验模型是否有值 给自己单独的控件赋值
        guard let anchor = anchor else {
                return
            }
        self.adressBtn.setTitle(anchor.anchor_city, for: UIControlState.normal)
      }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
