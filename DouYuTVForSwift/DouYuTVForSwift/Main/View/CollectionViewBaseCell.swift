//
//  CollectionViewBaseCell.swift
//  DouYuTVForSwift
//
//  Created by t4 on 17/5/18.
//  Copyright © 2017年 t4. All rights reserved.
//

import UIKit

class CollectionViewBaseCell: UICollectionViewCell {
    @IBOutlet weak var onLineBtn: UIButton!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var roomImageView: UIImageView!
    
    
    var anchor : AnchorModel?{
        didSet {
            
            //1.检验模型是否有值
            guard let anchor = anchor else {
                return
            }
            //2.给控件属性赋值
            self.nickNameLabel.text = anchor.nickname
            self.roomImageView.kf.setImage(with: URL(string: (anchor.vertical_src)!))
            //3.将在线人数从NSNumber 转化为Int
            let onlineNum =  anchor.online as! Int
            //显示在线人数的文字
            var onlineStr : String = ""
            if  onlineNum >= 10000 {
                
                onlineStr = String(format: "%.2f", Double(onlineNum)/Double(10000))+"万在线"
            }else{
                onlineStr = "\(onlineNum)"+"在线"
            }
            self.onLineBtn.setTitle(onlineStr, for: .normal)
        }
    }

}
