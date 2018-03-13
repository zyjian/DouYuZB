//
//  UIBarButtonItem-Extension.swift
//  DouYuZB
//
//  Created by zhu on 2018/3/7.
//  Copyright © 2018年 cn.jy. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    /*
     类方法创建
    class func createItem(imageName :String, hightImageName :String, size :CGSize) ->UIBarButtonItem {
        let btn = UIButton()
        btn.setImage(UIImage.init(named: imageName), for: .normal)
        btn.setImage(UIImage.init(named: hightImageName), for: .highlighted)
        btn.frame = CGRect.init(origin: CGPoint.init(x: 0, y: 0), size: size)
        return UIBarButtonItem.init(customView: btn)
    }
    */
    
    convenience init(imageName :String, hightImageName :String = "", size :CGSize = CGSize.zero) {
        let btn = UIButton()
        btn.setImage(UIImage.init(named: imageName), for: .normal)
        if hightImageName != "" {
            btn.setImage(UIImage.init(named: hightImageName), for: .highlighted)
        }
        if size == CGSize.zero {
            btn.sizeToFit()
        }else{
            btn.frame = CGRect.init(origin: CGPoint.init(x: 0, y: 0), size: size)
        }
        self.init(customView: btn)
    }
}


