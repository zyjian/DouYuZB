//
//  RecommendModel.swift
//  DouYuZB
//
//  Created by zhu on 2018/3/9.
//  Copyright © 2018年 cn.jy. All rights reserved.
//

import UIKit
import SwiftyJSON

struct RecommendModel {
    var room_list:[RoomModel] = [RoomModel]()
    var tag_name : String?
    var tag_id:Int?
    var push_vertical_screen : Int?
    var push_nearby:Int?
    var icon_url : String?
    var icon_name : String?

    init() {
        //  在构造函数中,如果没有明确调用super.init(),那么系统会帮助调用
    }
    
    init(jsonData: JSON) {
        tag_name = jsonData["tag_name"].stringValue
        icon_url = jsonData["icon_url"].stringValue
        
        tag_id = jsonData["tag_id"].intValue
        push_vertical_screen = jsonData["push_vertical_screen"].intValue
        push_nearby = jsonData["push_nearby"].intValue
        
        let rooms = jsonData["room_list"].arrayValue
        room_list = [RoomModel]()
        for room in rooms {
            let roommodel = RoomModel.init(jsonData: room)
            room_list.append(roommodel)
        }
    }
}



