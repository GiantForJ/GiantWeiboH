//
//  NetworkTools.swift
//  GiantWeibo
//
//  Created by SH15BG0110 on 16/4/26.
//  Copyright © 2016年 SH15BG0110. All rights reserved.
//

import UIKit
import AFNetworking

class NetworkTools: AFHTTPSessionManager {
    
    //常量只能赋值一次  切线程安全
    static let tools:NetworkTools = {
        //注意:baseURL一定要以/结尾
        let url = NSURL(string: "https://api.weibo.com/")
        let t = NetworkTools(baseURL: url)
        
        //设置AFN能够接受的数据类型
        t.responseSerializer.acceptableContentTypes = NSSet(objects: "application/json", "text/json", "text/javascript", "text/plain") as? Set<String>
        return t
        
    }()
    
    //    static let tools:NetworkTools = NetworkTools()
    /**
     获取单利的方法
     */
    class func shareNetworkTools() -> NetworkTools {
        return tools
    }
    
    
    
}
