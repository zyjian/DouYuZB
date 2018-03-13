//
//  Date-Extension.swift
//  DouYuZB
//
//  Created by zhu on 2018/3/9.
//  Copyright © 2018年 cn.jy. All rights reserved.
//

import UIKit

extension Date {
    static func getCurrentTime() ->String {
        let now = Date()
        let nowCount = Int(now.timeIntervalSince1970)
        return "\(nowCount)"
    }
}
