//
//  PageTitleView.swift
//  DouYuTVForSwift
//
//  Created by t4 on 17/4/14.
//  Copyright © 2017年 t4. All rights reserved.
//

import UIKit


@objc protocol PageTitleViewDelegate : class {

    /* 
     *titleView:标题视图
     *index 选中的标题下标
     */
    func pageTitleView(titleView:PageTitleView,selectViewIndex index : Int)


}


///滚动视图下边的线的高度
fileprivate let kScrollViewLineH : CGFloat = 2.5
///选中label的颜色
fileprivate var selectLabelTextColor : (CGFloat,CGFloat,CGFloat) = (255,128,0)
///正常label的颜色
fileprivate var normalLabelTextColor : (CGFloat,CGFloat,CGFloat) = (85,85,85)

class PageTitleView: UIView {

    //MARK: - 定义属性

    ///标题数组
    fileprivate var titles : [String]
    ///存放label的数组
    fileprivate var titleLabels : [UILabel] = [UILabel]()
    ///当前label的下标
    fileprivate var  currentIndex : Int = 0
    ///定义代理
    weak var delegate : PageTitleViewDelegate?
    
    //MARK: - 懒加载属性
    ///标题滚动视图scrollView
    fileprivate lazy var scrollView : UIScrollView = {
    
     let scrollView = UIScrollView()
     scrollView.showsHorizontalScrollIndicator = false
     scrollView.scrollsToTop = false
     scrollView.bounces = false
    
     return scrollView
    
    }()
    
    ///标题滚动视图底边滑块
    fileprivate lazy var scrollViewLine : UIView = {
       let scrollViewLine = UIView()
        
       scrollViewLine.backgroundColor = UIColor.orange
    
       return scrollViewLine
    }()
    
    
    
    //MARK: - 自定义构造函数
     init(frame: CGRect,titles:[String]) {
        self.titles = titles//保存传过来的标题
        
        super.init(frame: frame)
    
         setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}

extension PageTitleView {

    //MARK: - 布局界面
    fileprivate func  setupUI() {
    
    //1.添加UIScrollView
        addSubview(scrollView)
        scrollView.frame = self.bounds
    //2. 添加对应的label
        setUpTitleLabels()
    //3. 设置底线和滚动的滑块
        setUpBottomMenuAndScrollViewLine()
    }
    
   //MARK: - 给scrollview添加label
    fileprivate func setUpTitleLabels(){
    
       
        let  labelW = frame.width/CGFloat(titles.count)
        let  labelH = frame.height - kScrollViewLineH
        let  labelY :CGFloat =  0
        
        //用过这种方式既可以得到下标 也可以得到标题
        for (index,title) in titles.enumerated() {
        
            //1.创建并设置label属性
            let label = UILabel()
            label.text = title
            label.tag = index
            label.font = UIFont.boldSystemFont(ofSize: 16)
            label.textColor = UIColor(r: normalLabelTextColor.0, g: normalLabelTextColor.1, b: normalLabelTextColor.2, alpha: 1.0)
            label.textAlignment = .center
            
           //2.设置label的frame
            let labelX : CGFloat = labelW * CGFloat(index)
            
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
           //3.将label添加到scrollView中
            scrollView.addSubview(label)
            
           //4.将创建的label加到数组中
            titleLabels.append(label)
            
          //5.给label 添加点击手势
            label.isUserInteractionEnabled = true
            let  tap  = UITapGestureRecognizer(target: self, action: #selector(self.clickLabelAction(tapGes:)))
            label.addGestureRecognizer(tap)
        }
    }

    
    //MARK: - 给scrollview添加底线以及滑块
    fileprivate func setUpBottomMenuAndScrollViewLine(){
    
     //1.添加底线
        let bottomLine = UIView(frame: CGRect(x: 0, y: frame.height-0.5, width: frame.width, height: 0.5))
        bottomLine.backgroundColor = UIColor.lightGray
        addSubview(bottomLine)
    //2.添加滑块
        //2.1 找到label数组中的第一个label
        guard let firstLabel = titleLabels.first else {
            
            return
        }
        firstLabel.textColor = UIColor(r: selectLabelTextColor.0, g: selectLabelTextColor.1, b: selectLabelTextColor.2, alpha: 1.0)
        //2.2设置底边滑块
        scrollView.addSubview(scrollViewLine)
        scrollViewLine.frame = CGRect(x: 0, y: frame.height-kScrollViewLineH, width:firstLabel.frame.width, height: kScrollViewLineH)
    
    }
    
    
    //MARK: - 监听label的点击事件
    @objc fileprivate func  clickLabelAction (tapGes:UITapGestureRecognizer) {
        
        //0.获取当前label
        guard  let currenLabel  = tapGes.view as? UILabel else {
            return
        }
        
        //1. 如果点击的是同一个label, 那么直接返回
        if currenLabel.tag == currentIndex {
            
            return
        }
        
       
      //2.找到原来的label  默认第一个是原来的label
        let  oldLabel = self.titleLabels[currentIndex]
        
      //3.修改当前label 以及原来 label 的文字颜色
        currenLabel.textColor = UIColor(r: selectLabelTextColor.0, g: selectLabelTextColor.1, b: selectLabelTextColor.2, alpha: 1.0)
        oldLabel.textColor = UIColor(r: normalLabelTextColor.0, g: normalLabelTextColor.1, b: normalLabelTextColor.2, alpha: 1.0)
     //4. 保存当前label的下标值  就是label得tag
        currentIndex = currenLabel.tag
     //5. 滚动条位置发生改变
        let scrollViewLineX = CGFloat(currentIndex)*scrollViewLine.frame.width
        
        UIView.animate(withDuration: 0.15) {
            self.scrollViewLine.frame.origin.x = scrollViewLineX
        }
     //6. 挂上代理 通知代理执行切换内容视图
        delegate?.pageTitleView(titleView: self, selectViewIndex: currentIndex)
    
    }

   //MARK: - 对外暴露的方法  
    //通过HomeVC代理方法 将进度、目标控制器、来源控制器下标传递给titleView
    
    func  changeTitleViewSelectIndex(progress:CGFloat,sourceIndex:Int,targetIndex:Int){
       //1.拿到目标label 以及来源label
        let  targetLabel = self.titleLabels[targetIndex]
        let  sourceLabel = self.titleLabels[sourceIndex]
        
        
        //2.处理滑块逻辑
        let moveToLabelX = targetLabel.frame.origin.x-sourceLabel.frame.origin.x //获取从这个label滑动到下个label总共需要滑动距离
        let moveCurrentX = moveToLabelX*progress //获取当前滑动的比例
        
        
        self.scrollViewLine.frame.origin.x = moveCurrentX+sourceLabel.frame.origin.x //当前已经滑动的距离+来源label的x 等于滑块的x
        //3.处理颜色的渐变
        //3.1获取颜色变化的范围
        let colorDelta = (selectLabelTextColor.0-normalLabelTextColor.0,selectLabelTextColor.1-normalLabelTextColor.1,selectLabelTextColor.2-normalLabelTextColor.2)
        
        //3.3获取来源label 的颜色
        sourceLabel.textColor = UIColor(r: selectLabelTextColor.0-colorDelta.0*progress, g: selectLabelTextColor.1-colorDelta.1*progress, b: selectLabelTextColor.2-colorDelta.2*progress, alpha: 1.0)
        //3.2  获取目标label的颜色
        
        targetLabel.textColor = UIColor(r: normalLabelTextColor.0+colorDelta.0*progress, g: normalLabelTextColor.1+colorDelta.1*progress, b: normalLabelTextColor.2+colorDelta.2*progress, alpha: 1.0)
        
       //4.记录最新的index
        currentIndex = targetIndex;
     
    }
}
