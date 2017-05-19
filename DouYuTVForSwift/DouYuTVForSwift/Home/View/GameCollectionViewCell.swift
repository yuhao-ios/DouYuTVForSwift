//
//  GameCollectionViewCell.swift
//  DouYuTVForSwift
//
//  Created by t4 on 17/5/18.
//  Copyright © 2017年 t4. All rights reserved.
//

import UIKit
import Kingfisher

class GameCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleTextLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    var group : AnchorGroupModel?{
    
        didSet {
            guard let group = group else {
                return
            }
           self.titleTextLabel.text = group.tag_name
            if let url = group.icon_url {
            self.iconImageView.kf.setImage(with: URL(string:url), placeholder: UIImage(named:"img_loading_1"), options: nil, progressBlock: nil, completionHandler: nil)
            }else{
            
              self.iconImageView.image = UIImage(named: "home_more_btn")
            }
        }
    
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        
    }

}
