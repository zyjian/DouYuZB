//
//  UIColor-Extension.swift
//  DouYuZB
//
//  Created by zhu on 2018/3/8.
//  Copyright © 2018年 cn.jy. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
}
