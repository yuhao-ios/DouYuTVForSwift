//
//  HomeVC.swift
//  DouYuTVForSwift
//
//  Created by t4 on 17/4/14.
//  Copyright © 2017年 t4. All rights reserved.
//

import UIKit
///TitleView的高度
fileprivate let kPageTitleViewH : CGFloat = 40

class HomeVC: UIViewController {

    //MARK: 懒加载
    let titles = ["推荐","游戏","娱乐","趣玩"]
    //标题视图
   fileprivate lazy var pageTitleView : PageTitleView = { [weak self] in
    
    let titleViewFrame = CGRect(x: 0, y:kStatusBarH+kNaviBarH , width: kMainWidth, height: kPageTitleViewH)
   
    
    let titleView = PageTitleView(frame: titleViewFrame, titles: (self?.titles)!)
    
    return titleView
    }()
    //标题视图对应的内容视图
    fileprivate lazy var pageContentView:PageContentView = { [weak self] in

     
        //1.确定内容视图的frame
        let contentViewFrame : CGRect = CGRect(x: 0, y: kStatusBarH+kNaviBarH+kPageTitleViewH, width: kMainWidth, height: kMainHeight-kStatusBarH-kNaviBarH-kPageTitleViewH-kTabBarH)
        //2.确定内容视图所有的子控制器
        var childVcs = [UIViewController]()
        childVcs.append(RecommendVC())
        for _ in 0..<((self?.titles.count)!-1){
            let vc = UIViewController()
         
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(UInt32(255))), g:  CGFloat(arc4random_uniform(UInt32(255))), b:  CGFloat(arc4random_uniform(UInt32(255))), alpha: 1)
           childVcs.append(vc)
        }
        //3.初始化内容视图
        let pageContentView = PageContentView(frame: contentViewFrame, childVcs: childVcs, parentViewController: self)
        
        return pageContentView
    }()
    
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        
        
    }

 
}

//MARK: - 布局界面
extension  HomeVC {

    //MARK: - 设置UI
    fileprivate func setUpUI() {
         //0.不需要系统调整scrollview类边距
        automaticallyAdjustsScrollViewInsets = false
        
        //1.设置导航栏
        setUpNavigationBar()

        
       //2.添加标题视图
        view.addSubview(pageTitleView)
        
        pageTitleView.delegate = self
        
      //3.添加标题视图对应的内容视图
        view.addSubview(pageContentView)
         pageContentView.delegate = self as PageContentViewDelegate?
       
    }
    
    //MARK: - 设置导航栏
    fileprivate func setUpNavigationBar(){
    
    //1.设置导航栏左侧视图
        
        //1.1.通过类扩展  创建UIBarButtonItem
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(imageName: "logo", heightImageName: nil, size: nil)
    //2. 设置导航栏右侧视图
        //2.1 创建  浏览记录 、扫描 、 搜索三个item
        
        let size  = CGSize(width: 40, height: 40)
        
        
        let historyItem = UIBarButtonItem.init(imageName: "image_my_history", heightImageName: "Image_my_history_click", size: size)
        
        
         let searchItem = UIBarButtonItem.init(imageName: "btn_search", heightImageName: "btn_search_clicked", size: size)
        
        
         let qrcodeItem = UIBarButtonItem.init(imageName: "Image_scan", heightImageName: "Image_scan_click", size: size)
        //2.2把item设置为导航栏右侧视图
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
    }

}


//MARK: - 代理协议
extension HomeVC : PageTitleViewDelegate,PageContentViewDelegate{


    func pageTitleView(titleView: PageTitleView, selectViewIndex index: Int) {
        
        //调用方法 通知内容视图做出相应的改变
        pageContentView.selectIndexForTitleMakeContentViewChange(index: index)
        
    }
 
   
    func pageContentView(contentView: PageContentView, progress: CGFloat, scrollOfIndex sourceIndex: Int, targetIndex: Int) {
        //调用方法 通知标题视图做出相应改变
        pageTitleView.changeTitleViewSelectIndex(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    
    
    
    
    }
    
    


}



