//
//  BaseViewController.swift
//  DouYuTVForSwift
//
//  Created by t4 on 17/5/24.
//  Copyright © 2017年 t4. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    
    //MARK: - 懒加载属性
    lazy var annimaImageView : UIImageView = { [unowned self] in
    
        let imageView = UIImageView(image: UIImage(named: "img_loading_1"))
        
        imageView.center = self.view.center
        
        imageView.animationImages = [UIImage(named: "img_loading_1")!,UIImage(named: "img_loading_2")!]
        
        imageView.animationDuration = 0.5
        
        imageView.animationRepeatCount = LONG_MAX
        
        imageView.autoresizingMask = [.flexibleTopMargin,.flexibleBottomMargin]
        
        return imageView
        
    }()
    
    var contentView  :  UIView?
    
    
    //MARK: - 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
     
        loadUI()
    }
    
}


extension BaseViewController {

    //布局
    func loadUI(){
        //1.隐藏内容视图
        contentView?.isHidden = true
        //2.添加执行动画的UIImageView
        view.addSubview(annimaImageView)
        //3.执行动画
        annimaImageView.startAnimating()
        
        // 4.设置view的背景颜色
        view.backgroundColor = UIColor(r: 250, g: 250, b: 250, alpha: 1.0)
    }

    func showContentView(){
    
        //0.隐藏动画视图
        annimaImageView.isHidden = true
        //1. 显示内容视图
        contentView?.isHidden = false
         //2.停止动画
        annimaImageView.stopAnimating()
    }


}
