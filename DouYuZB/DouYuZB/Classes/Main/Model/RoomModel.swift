//
//  RoomModel.swift
//  DouYuZB
//
//  Created by zhu on 2018/3/11.
//  Copyright © 2018年 cn.jy. All rights reserved.
//

import UIKit
import SwiftyJSON

struct RoomModel {
    var specific_catalog:String?
    var vertical_src:String?
    var nickname :String?
    var game_name:String?
    var room_name:String?
    var anchor_city:String?
    var icon_url:String?
    var tag_name:String?

    var room_id:Int?
    var show_time:Int?
    var isVertical:Int?
    var owner_uid:Int?
    var online:Int?
    
    
    init() {
        
    }
    init(jsonData:JSON) {
        specific_catalog = jsonData["specific_catalog"].stringValue
        vertical_src = jsonData["vertical_src"].stringValue
        nickname = jsonData["nickname"].stringValue
        game_name = jsonData["game_name"].stringValue
        room_name = jsonData["room_name"].stringValue
        anchor_city = jsonData["anchor_city"].stringValue
        icon_url = jsonData["icon_url"].stringValue
        tag_name = jsonData["tag_name"].stringValue

        
        online = jsonData["online"].intValue
        room_id = jsonData["room_id"].intValue
        show_time = jsonData["show_time"].intValue
        isVertical = jsonData["isVertical"].intValue
        owner_uid = jsonData["owner_uid"].intValue

    }
}


