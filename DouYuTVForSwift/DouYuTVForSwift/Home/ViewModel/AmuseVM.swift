//
//  AmuseVM.swift
//  DouYuTVForSwift
//
//  Created by t4 on 17/5/22.
//  Copyright © 2017年 t4. All rights reserved.
//

import UIKit

class AmuseVM: BaseAnchorVM {

       func loadAmuseAllData(finishCallBack:@escaping()->()){

        loadAnchorAllData(url: "http://capi.douyucdn.cn/api/v1/getHotRoom/2",parameters: nil,isGroupData: true, finishCallBack: finishCallBack)
       }

}
