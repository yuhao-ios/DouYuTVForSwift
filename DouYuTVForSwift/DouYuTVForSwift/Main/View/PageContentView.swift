//
//  PageContentView.swift
//  DouYuTVForSwift
//
//  Created by t4 on 17/4/17.
//  Copyright © 2017年 t4. All rights reserved.
//

import UIKit

protocol  PageContentViewDelegate : class {
    
    /**
     *contentView:自身
     *progress : 滑动切换的进度
     *sourceIndex: 来源视图的下标
     *targetIndex: 目标视图的下标
     */
    func pageContentView(contentView:PageContentView,progress:CGFloat,scrollOfIndex sourceIndex : Int,targetIndex:Int)
}


fileprivate let PageCellID = "cell"
///标题对应的内容视图
class PageContentView: UIView {

    //MARK: - 属性
    ///存放所有子控制器的数组
    fileprivate var childVcs:[UIViewController] = [UIViewController]()
    ///存放所有子控制器的父控制器 weak只能修饰可选类型
    /*
     为什么使用weak 修饰 parentViewController？
     避免循环引用  
     在HomeVC创建pageContentView默认是强引用   在PageContentView中使用parentViewController 接收 HoemVC   默认也是强引用 如果不加weak修饰 
     就会造成循环引用 两个对象都不能释放
     */
    fileprivate weak var parentViewController:UIViewController?
    
    ///记录 开始滑动的距离
    fileprivate var startOfSetx : CGFloat = 0
    ///判断是滚动切换还是点击标题视图切换
    fileprivate var isForbidScrollDelegate  : Bool = false
    
    /// 申明的代理
    weak var delegate : PageContentViewDelegate?
    
    //MARK: - 懒加载
    ///创建collectionView 存放控制器  在闭包中调用self 为了避免循环引用 也需要加weak
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
    
       //1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal//设置水平滚动
      //2.创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource  = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: PageCellID)
       return collectionView
    }()
    
    
    
    
    
   //MARK: - 自定义构造函数
    /* 自定义构造函数进行初始化
     * childVcs: 首页scrollView对应的每一个子控制器
     * parentViewController： 父控制器
     */
    init(frame: CGRect,childVcs: [UIViewController],parentViewController:UIViewController?) {
        super.init(frame:frame)
        
        self.childVcs = childVcs
        
        self.parentViewController = parentViewController
        //布局
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//MARK: - 布局 / 方法
extension PageContentView {

    //MARK： - 设置UI界面
    fileprivate func setUpUI() {
    
        //1.取出所有子控制器 并添加到父控制器
        for childVC in self.childVcs {
            
            parentViewController?.addChildViewController(childVC)
        }
       //2. 添加collectionView，在cell中添加子控制器控制器上的view
    
        addSubview(collectionView)
        
        collectionView.frame = bounds
    }
    
    
    
    //MARK: - 对外暴露的方法  
    //通过外界传过来选中的标题 切换标题对应的内容 
    func  selectIndexForTitleMakeContentViewChange(index:Int){
    
        isForbidScrollDelegate = true;//点击标题切换 禁止滚动切换
        //计算需要偏移的位置
        let collectionViewScrollOfSetX = CGFloat(index)*self.collectionView.frame.width
        //开始偏移
        collectionView.setContentOffset(CGPoint(x:collectionViewScrollOfSetX,y:0), animated: true)
    }

}



//MARK: -  代理协议
extension PageContentView : UICollectionViewDataSource,UICollectionViewDelegate{


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
    
        return  childVcs.count
    }
    
    func  collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //1.创建cell
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: PageCellID, for: indexPath)
        
        //2.避免循环引用 移除cell上的所有子视图
        for view in cell.contentView.subviews {
            
            view.removeFromSuperview()
        }
        
        //3. 将子控制器的视图添加在cell上
        let childVC : UIViewController = self.childVcs[indexPath.row]
        
        childVC.view.frame = cell.contentView.frame
        
        cell.contentView.addSubview(childVC.view)
    
        return  cell
        
    }
    
    //开始拖拽滑动时候
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
     isForbidScrollDelegate  = false//不禁止滚动切换
        
       startOfSetx = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //如果禁止滚动切换直接return
        if isForbidScrollDelegate {
            return
        }
        
        //1.定义需要获取的数据
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        
        //2. 判断偏移 是左滑还是右滑  滑动距离变大 <-左滑  变小 右滑->
        
        let currenOffsetx = scrollView.contentOffset.x
        
        if  currenOffsetx > startOfSetx {
            //左滑
            //2.1计算进度  floor 取整（ floor(currenOffsetx/scrollView.frame.width) 如果滑动距离没有大于等于scrollView.frame.width那么会一直等于0）
    
            progress = (currenOffsetx/scrollView.frame.width) - floor(currenOffsetx/scrollView.frame.width)
            //2.2计算原来的index
            sourceIndex = Int(currenOffsetx/scrollView.frame.width)
       
            //2.3 计算目标的index
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count {//当目标控制器下标 大于等于 控制器个数 让他始终等于最后一个
                targetIndex = childVcs.count-1 //也就是还是最后一个
            }
      
            // 4.如果完全划过去
            if currenOffsetx - startOfSetx == scrollView.frame.width {
                progress = 1
                targetIndex = sourceIndex
            }
        }else {
            //右滑
           progress = 1 - ((currenOffsetx/scrollView.frame.width) - floor(currenOffsetx/scrollView.frame.width))
          
            //计算目标index
            targetIndex = Int(currenOffsetx/scrollView.frame.width)
            
            sourceIndex = targetIndex+1
         
            if sourceIndex >= childVcs.count {
            
              sourceIndex = childVcs.count - 1
            }
        }
        
        //挂上代理
        delegate?.pageContentView(contentView: self, progress: progress, scrollOfIndex: sourceIndex, targetIndex: targetIndex)
    }
}
