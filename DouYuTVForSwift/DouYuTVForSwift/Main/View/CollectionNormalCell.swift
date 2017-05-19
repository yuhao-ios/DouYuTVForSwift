//
//  CollectionNormalCell.swift
//  DouYuTVForSwift
//
//  Created by t4 on 17/5/9.
//  Copyright © 2017年 t4. All rights reserved.
//

import UIKit

class CollectionNormalCell: CollectionViewBaseCell {


    @IBOutlet weak var roomTitleLabel: UILabel!
    
    override var anchor : AnchorModel?{
        didSet {
            //0.把数据模型传递给父类
            super.anchor = anchor
            //1.校验模型是否有值
            guard let anchor = anchor else {
                return
            }
            //2.给控件属性赋值
            self.roomTitleLabel.text = anchor.room_name
            
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
