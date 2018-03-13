//
//  Common.swift
//  DouYuZB
//
//  Created by zhu on 2018/3/7.
//  Copyright © 2018年 cn.jy. All rights reserved.
//

import UIKit

let kScreenW = UIScreen.main.bounds.size.width
let kScreenH = UIScreen.main.bounds.size.height

let IS_IPHONE_X = (kScreenH == 812.0) ? true : false
let kStateH = kStateHeight()
func kStateHeight() -> CGFloat {
    if IS_IPHONE_X == true {
        return 44
    }else{
        return 20
    }
}

let kNavgitionH : CGFloat = 44
let kTabBarH : CGFloat = IS_IPHONE_X ? 83 : 44
let kNavAndStateH : CGFloat = kStateH + kNavgitionH



