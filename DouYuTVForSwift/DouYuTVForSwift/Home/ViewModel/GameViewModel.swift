//
//  GameViewModel.swift
//  DouYuTVForSwift
//
//  Created by t4 on 17/5/19.
//  Copyright © 2017年 t4. All rights reserved.
//

import UIKit

class GameViewModel: NSObject {
    
    //MARK：存放game的数组
    var games : [GameModel] = [GameModel]()
    

    //加载所有游戏数据
    func loadAllGameData(finishedCallBack:@escaping()->()){
    
     NetworkTools.requestData(type: .GET, url: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName":"game"]) { (respone) in
         //1.校验数据
         guard respone is [String:Any] else {
        
             return
           }
        //2.取出字典数组
         guard  let result = respone["data"] as? [[String:NSObject]] else{
        
        
            return
          }
       
        //3.便利字典数组  并转模型
          for dict in result {
        
            let game = GameModel(dict:dict)
         
             self.games.append(game)
         }
        //4.完成回调
         finishedCallBack()
       }
    }
    
    
    
}
