//
//  FunnyVM.swift
//  DouYuTVForSwift
//
//  Created by t4 on 17/5/22.
//  Copyright © 2017年 t4. All rights reserved.
//

import UIKit

class FunnyVM: BaseAnchorVM {

    func loadFunnyAllData(finishedCallback:@escaping()->()) {
        
        loadAnchorAllData(url: "http://capi.douyucdn.cn/api/v1/getColumnRoom/3", parameters: ["limit":30,"offset":0],isGroupData: false, finishCallBack: finishedCallback)
    }
}
