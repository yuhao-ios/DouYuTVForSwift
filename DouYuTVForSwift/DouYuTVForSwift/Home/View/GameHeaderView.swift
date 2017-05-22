//
//  GameHeaderView.swift
//  DouYuTVForSwift
//
//  Created by t4 on 17/5/19.
//  Copyright © 2017年 t4. All rights reserved.
//

import UIKit

class GameHeaderView: UICollectionReusableView {


    @IBOutlet weak var titleTextLabel: UILabel!
    
    
    
   class  func shardGameHeaderView() -> GameHeaderView{
    
    
    return Bundle.main.loadNibNamed("GameHeaderView", owner: nil, options: nil)?.first as! GameHeaderView
    }
    
    
}
