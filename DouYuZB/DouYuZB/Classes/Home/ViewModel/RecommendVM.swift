//
//  RecommendVM.swift
//  DouYuZB
//
//  Created by zhu on 2018/3/9.
//  Copyright © 2018年 cn.jy. All rights reserved.
//

import UIKit
import SwiftyJSON

class RecommendVM {
    lazy var recommendArray = [RecommendModel]()
    private lazy var pettyGroup = RecommendModel()
    private lazy var bigDataGroup = RecommendModel()
    
    lazy var cycleArray = [CycleModel]()
    lazy var gameArray = [RoomModel]()

}

extension RecommendVM {
    func requestData(callBack:@escaping ()->()) {
        
        let disGroup = DispatchGroup()
        
        disGroup.enter()
        //3.请求第一部分推荐数据
        NetworkTools.requestData(type: .get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : Date.getCurrentTime()]) { (result) in
            let json = JSON(result)
            let data = json["data"].arrayValue

            for dic in data{
                let model = RoomModel.init(jsonData: dic)
                self.bigDataGroup.room_list.append(model)
            }
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"

            disGroup.leave()
        }
        

        
        disGroup.enter()
        //颜值数据 请求第二部分颜值数据
        let parameters : [String : Any] = ["limit":"4", "offset":"0", "time":Date.getCurrentTime()]
        NetworkTools.requestData(type: .get, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters ) { (result) in

            let json = JSON(result)
            let data = json["data"].arrayValue
            
            for room in data {
                self.pettyGroup.room_list.append(RoomModel.init(jsonData: room))
            }
            self.pettyGroup.tag_name = "颜值"
            self.pettyGroup.icon_name = "home_header_phone"
            
            disGroup.leave()
        }
        
        disGroup.enter()
        //请求2-12部分游戏数据
        NetworkTools.requestData(type: .get, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) { (result) in
            let json = JSON(result)
            let data = json["data"].arrayValue
            for dict in data {
                let recommendModel = RecommendModel.init(jsonData: dict)
                self.recommendArray.append(recommendModel)
            }
            disGroup.leave()
        }
        
        //数据排序
        disGroup.notify(queue: DispatchQueue.main) {
            self.recommendArray.insert(self.pettyGroup, at: 0)
            self.recommendArray.insert(self.bigDataGroup, at: 0)
            callBack()
        }
    }
    func requestCycleData(callBack:@escaping ()->()){
        
        NetworkTools.requestData(type: .get, URLString: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version" : "2.300"]) { (result) in
            
            let json = JSON(result)
            let data = json["data"].arrayValue
            for item in data {
                let model = CycleModel.init(jsonData: item)
                self.cycleArray.append(model)
            }
            callBack()
        }
    }
    func requestGameData(callBack:@escaping () -> ()){
        NetworkTools.requestData(type: .get, URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail") { (result) in
            let json = JSON(result)
            let data = json["data"].arrayValue
            for item in data {
                self.gameArray.append(RoomModel.init(jsonData: item))
            }
            callBack()
        }
    }
    
}
