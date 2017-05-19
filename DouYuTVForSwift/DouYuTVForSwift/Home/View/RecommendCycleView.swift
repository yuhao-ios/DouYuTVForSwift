//
//  RecommendCycleView.swift
//  DouYuTVForSwift
//
//  Created by t4 on 17/5/18.
//  Copyright © 2017年 t4. All rights reserved.
//

import UIKit


fileprivate let kCycleCellID = "cycleCell"

class RecommendCycleView: UIView {

    //MARK: - 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    var cyTimer : Timer?

    var cycles : [CycleViewModel]?{
       didSet{
        //1.刷新collectionView
        collectionView.reloadData()
        //2.设置pageControl的总页数
        pageControl.numberOfPages = cycles?.count ?? 0
        
        //3.为了让用户往前也能无限滚动  所以先让collectionView偏移到某个位置
        
        let indexPath =  IndexPath(item: (cycles?.count)!*500, section: 0)
        collectionView.scrollToItem(at: indexPath as IndexPath, at: .left, animated: false)
        
        //4. 先移除定时器 在添加定时器
            removeTimer()
            addTimer()
        }
        
    }
    
    
    //MARK:  - 通过类方法初始化
    class func recommendCycleView()->RecommendCycleView {
    
     return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
    //xib 加载完成
    override func awakeFromNib() {
        super.awakeFromNib()
        //设置该控件不随父控件拉伸
        self.autoresizingMask = .init(rawValue: 0)
        //注册cell
        collectionView.register(UINib.init(nibName: "CycleCollectionCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellID)
    }

    //更新布局  设置layout
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
    }
    
   //MARK: - 定时器相关
    //添加定时器
   fileprivate func  addTimer() {
    
    cyTimer = Timer(timeInterval: 2.0, target: self, selector:#selector(self.changeCurrent(time:)), userInfo: nil, repeats: true)
    
      RunLoop.main.add(cyTimer!, forMode: RunLoopMode.commonModes)
    }
     //移除定时器
    fileprivate func removeTimer(){
        
        cyTimer?.invalidate()
        cyTimer = nil
        
    }

    //偏移到下一页
    @objc fileprivate func changeCurrent(time:Timer){
    
      //获取当前偏移量
      let currectOfSetx = collectionView.contentOffset.x
     //获取下页的偏移量
      let nextOfSetx = currectOfSetx + collectionView.bounds.width
      //设置collectionView的偏移量
      collectionView.setContentOffset(CGPoint(x:nextOfSetx,y:0), animated: true)
    }
}


//MARK: - 代理相关
extension RecommendCycleView : UICollectionViewDelegate,UICollectionViewDataSource{
    //MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //无限滚动的实现 就是乘以无限大的基数
        return  (cycles?.count ?? 0)*10000
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView .dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! CycleCollectionCell
        cell.cycle = cycles?[indexPath.item % (cycles?.count)!]
       return cell
    }

    //MARK: - UIScrollViewDelegate
    //滚动结束时
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offSetx  = scrollView.contentOffset.x
        
        pageControl.currentPage = Int(offSetx/scrollView.bounds.width) % (cycles?.count)!
    }
    //监听用户拖拽 开始拖拽时候
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        removeTimer()
    
    }
    //结束拖拽
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addTimer()
    }
}
