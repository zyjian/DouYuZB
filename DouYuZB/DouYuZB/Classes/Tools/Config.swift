//
//  Config.swift
//  DouYuZB
//
//  Created by zhu on 2018/3/9.
//  Copyright © 2018年 cn.jy. All rights reserved.
//

import UIKit

//打印信息
func Log<T>(_ message : T, file : String = #file, funcName : String = #function, lineNum : Int = #line) {
    #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        print("\n>>> \(Date())  \(fileName) (line: \(lineNum)): \(message)\n")
    #endif
}

import SwiftyJSON
