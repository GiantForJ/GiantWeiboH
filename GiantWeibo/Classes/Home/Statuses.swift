//
//  Statuses.swift
//  GiantWeibo
//
//  Created by SH15BG0110 on 16/4/27.
//  Copyright © 2016年 SH15BG0110. All rights reserved.
//

import UIKit

class Statuses: NSObject{
    ///微博创建时间
    var created_at: String?
    ///微博ID
    var id: Int = 0
    ///微博信息内容
    var text:String?
    ///微博来源
    var source: String?
    ///配图数组
    var pic_urls: [[String: AnyObject]]?
    /// 用户信息
    var user: User?
    /**
     加载微博数据
     */
    class func loadStatuses(finished: (models:[Statuses]?,error:NSError?) -> ()){
        let path = "2/statuses/home_timeline.json"
        let params = ["access_token":UserAccount.loadAccount()!.access_token!]
        
        
        NetworkTools.shareNetworkTools().GET(path, parameters: params, success: { (_, JSON) in
            //            print(JSON)
            //1.取出statues key对应的数组 （存储的式字典）
            //2.遍历数组  将字典转换为模型
            let models = dict2Model(JSON!["statuses"] as! [[String: AnyObject]])
            //            print(models)
            //2.1通过闭包将数据传递给调用者
            finished(models: models, error: nil)
        }) { (_, error) in
            //            print(error)
            finished(models: nil, error: error)
            
        }
    }
    
    /**
     将字典数组转化为模型数组
     
     */
    class func dict2Model(list: [[String: AnyObject]]) -> [Statuses] {
        var models = [Statuses]()
        
        for dict in list {
            models.append(Statuses(dicr: dict))
        }
        return models
    }
    
    
    //字典转模型
    init(dicr: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dicr)
    }
    
    //setValuesForKeysWithDictionary内部会调用一下方法
    override func setValue(value: AnyObject?, forKey key: String) {
        //1.判断当前是否正在给微博字典中的user字典赋值
        if "user" == key {
            //2.将userkey对应的字典创建一个模型
            user = User(dicr: value as! [String : AnyObject])
            return
        }
        super.setValue(value, forKey: key)
//        print("key =\(key),value=\(value)")
        
    }
    /**
     不一一对应
     */
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    //打印当前模型
    var properties = ["created_at","id","text","source","pic_urls"];
    override var description: String {
        let dict = dictionaryWithValuesForKeys(properties)
        
        return "\(dict)"
        
    }
}
