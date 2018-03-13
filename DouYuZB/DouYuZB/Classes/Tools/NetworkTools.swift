//
//  NetworkTools.swift
//  DouYuZB
//
//  Created by zhu on 2018/3/9.
//  Copyright © 2018年 cn.jy. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case get
    case post
}

extension Dictionary {
    func dic2urlString() -> String {
        let muStr:NSMutableString = NSMutableString()
        
        for (k,v) in self {
            let temp : String = "\(k)=\(v)&"
            muStr.append(temp)        }
        
        return String(muStr.substring(to: muStr.length-1))
    }
}

class NetworkTools {
    class func requestData(type :MethodType, URLString: String , parameters: [String : Any]? = nil ,finishedCallback:@escaping ( _ result : AnyObject) -> ()) {
        
        //1.获取类型
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        // 请求头
        var headers: [String : String]? {
            return ["Content-type" : "application/json"]
        }
        //2.发送网络请求
        Alamofire.request(URLString, method: method, parameters: parameters, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            
            //3.获取结果
            guard let result = response.result.value else {
                Log("请求错误\(String(describing: response.result.error))")
                return
            }
            
            if parameters != nil {
                Log("\(URLString)?\n\(parameters!.dic2urlString()) \n \(String(describing: response.result.value))")
            }
            //4.将结果返回
            finishedCallback(result as AnyObject)
        }
    }
}

// 扩展方法
private extension String {
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}


