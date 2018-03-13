//
//  CycleModel.swift
//  DouYuZB
//
//  Created by zhu on 2018/3/12.
//  Copyright © 2018年 cn.jy. All rights reserved.
//

import UIKit
import SwiftyJSON

struct CycleModel {
    var title:String?
    var pic_url:String?
    
    var room:RoomModel?
    
    init(jsonData:JSON) {
        title = jsonData["title"].stringValue
        pic_url = jsonData["pic_url"].stringValue
        room = RoomModel.init(jsonData: jsonData["room"])
    }
}
