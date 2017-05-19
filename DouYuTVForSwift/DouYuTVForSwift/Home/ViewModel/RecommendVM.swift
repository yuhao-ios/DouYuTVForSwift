//
//  RecommendVM.swift
//  DouYuTVForSwift
//
//  Created by t4 on 17/5/10.
//  Copyright © 2017年 t4. All rights reserved.
//

import UIKit

class RecommendVM: NSObject {
    //存放所有数据的数组
    var anchorGroups : [AnchorGroupModel] = [AnchorGroupModel]()
    //所有的颜值组数据
    fileprivate  var pettrys :AnchorGroupModel = AnchorGroupModel()
    //热门推荐数据
    fileprivate  var hots :AnchorGroupModel = AnchorGroupModel()
    
    var cycles : [CycleViewModel] = [CycleViewModel]()
    
    //MARK: - 请求推荐直播的网络数据
    func requestData(finishedCallback:@escaping ()->()){
    
    let parameter =  ["limit":"4","offset":"0","time":NSDate.getCurrentTime()]
    //创建队列
    let  aGroup = DispatchGroup.init()
    
    
    ///1.请求第一部分推荐的数据
    //1.1进入队列组
     aGroup.enter()
     NetworkTools.requestData(type: .GET, url: "http://capi.douyucdn.cn/api/v1/getbigDataRoom",parameters:["time":NSDate.getCurrentTime()]) { (respone) in
        
        //1.2将数据转化为字典类型
        guard let result = respone as? [String : NSObject] else{
            
            return
        }
        //1.3.根据data key 读取字典数组
        
        guard let dataArray = result["data"] as? [[String : NSObject]] else {
            
            return;
        }
        
        self.hots.tag_name = "热门推荐"
        self.hots.icon_name = "home_header_hot"
        //1.4.便利数组 取出每一组字典模型(房间数据)
        for dict in dataArray {
            
            let anchor = AnchorModel(dict: dict)
            
            self.hots.anchors.append(anchor)
            
        }
        //1.5. 离开队列组
        aGroup.leave()
        
    }

    ///2.请求第二部分颜值的数据
    aGroup.enter()
    NetworkTools.requestData(type: .GET, url: "http://capi.douyucdn.cn/api/v1/getVerticalRoom",parameters:parameter) { (respone) in

        //1.将数据转化为字典类型
        guard let result = respone as? [String : NSObject] else{
            
            return
        }
        //2.根据data key 读取字典数组
        
        guard let dataArray = result["data"] as? [[String : NSObject]] else {
            
            return;
        }
        
        self.pettrys.tag_name = "颜值担当"
        self.pettrys.icon_name = "home_header_phone"
        //3.便利数组 取出每一组字典模型(房间数据)
        for dict in dataArray {
            
            let anchor = AnchorModel(dict: dict)
            
            self.pettrys.anchors.append(anchor)
            
        }
    
      aGroup.leave()
    }
    
    ///3.请求第三部分 剩下的数据
    /*
     *limit:请求数据的个数 相当于cell个数
     *offset：偏移
     *time：当前时间
     http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=
     */
    aGroup.enter()
        NetworkTools.requestData(type: .GET, url: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameter) { (respone) in
            
            //1.将数据转化为字典类型
            guard let result = respone as? [String : NSObject] else{
            
             return
            }
            //2.根据data key 读取字典数组
            guard let dataArray = result["data"] as? [[String : NSObject]] else {
            
                return;
            }
            //3.便利数组 取出每一组字典模型（组的基本数据）
            for dict in dataArray {
             
                let group = AnchorGroupModel(dict: dict)
                
                self.anchorGroups.append(group);
            }
          aGroup.leave()
        }
    
      aGroup.notify(queue: DispatchQueue.main) {
        print("数据请求完毕");
        //分别将热门 以及 颜值组的组数据插入到总数据中
        self.anchorGroups .insert(self.pettrys, at: 0)
        self.anchorGroups.insert(self.hots, at: 0)
        //加载数据成功后的回调
        finishedCallback()
      }
  }
    
    //MARK: - 请求无限轮播的数据
    func requestCycleData(finishCallBack:@escaping()->() ) {
        
        NetworkTools.requestData(type: .GET, url: "http://capi.douyucdn.cn/api/v1/slide/6",parameters:["version":"2.300"]) { (respone) in
            
    
            guard let result = respone as? [String:NSObject] else {
            
                return
            }
            
            for dict in (result["data"] as? [[String:NSObject]])!{
            
                let cycle = CycleViewModel(dict: dict)
                
                self.cycles.append(cycle)
            }
        
           finishCallBack()
            
        }
    }
    
}
