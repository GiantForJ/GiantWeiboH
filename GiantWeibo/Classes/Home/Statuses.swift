//
//  Statuses.swift
//  GiantWeibo
//
//  Created by SH15BG0110 on 16/4/27.
//  Copyright © 2016年 SH15BG0110. All rights reserved.
//

import UIKit
import SDWebImage

class Statuses: NSObject{
    ///微博创建时间
    var created_at: String?
        {
        didSet{
            //1.将字符串转换为时间
            print(created_at)
            //            created_at = "Tue May 9 10:11:06 +0800 2014"
            let createdDate = NSDate.dateWithStr(created_at!)
            print(createdDate.descDate)
            //2.获取格式化之后的时间字符串
            created_at = createdDate.descDate
            
            /*
             NSDate: //时间
             //日历，可以去除一个NSDate中的时分秒 年月日
             //快速的判断两个时间是否是同一年
             NSCalendar；
             */
            //            let calendar = NSCalendar.currentCalendar()
            //            let flag = NSCalendarUnit(rawValue: UInt.max)
            //            var comps = calendar.components(flag, fromDate: createdDate)
            /*
             comps.year
             comps.month
             comps.day
             */
            //            if calendar.isDateInToday(createdDate) {
            //                print("今天")
            //            }
            //            
            //            if calendar.isDateInYesterday(createdDate) {
            //                print("昨天")
            //            }
            //通过以下方法可以获取两个之前之间相差的年
            //            comps = calendar.components(NSCalendarUnit.Year, fromDate: createdDate, toDate: NSDate(), options:  NSCalendarOptions(rawValue: 0))
            //            print(comps.year)
            
            
        }
    }
    ///微博ID
    var id: Int = 0
    ///微博信息内容
    var text:String?
    ///微博来源
    var source: String?
        {
        didSet{
            //1.截取字符串
            if let str = source {
                if str == "" {
                    return
                }
                //1.1获取开始截取的位置
                let startLocation = (str as NSString).rangeOfString(">").location + 1
                //1.2获取截取的长度
                let length = (str as NSString).rangeOfString("<", options: NSStringCompareOptions.BackwardsSearch).location - startLocation
                
                //1.3截取字符串
                source = "来自:" + (str as NSString).substringWithRange(NSMakeRange(startLocation, length))
                
                
            }
            
        }
    }
    ///配图数组
    var pic_urls: [[String: AnyObject]]?
        {
        didSet{
            //1.初始化数组
            storedPicURLS = [NSURL]()
            //2.遍历取出所有的图片路径字符串
            for dict in pic_urls! {
                if let urlStr = dict["thumbnail_pic"] {
                    //将字符串转化为URL保存到数组中
                    storedPicURLS?.append(NSURL(string: urlStr as! String)!)
                }
            }
        }
    }
    //保存当前微博所有配图的URL
    var storedPicURLS: [NSURL]?
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
            //3.缓存微博配图
            cacheStatusImages(models, finished: finished)
            //2.1通过闭包将数据传递给调用者
            //            finished(models: models, error: nil)
        }) { (_, error) in
            //            print(error)
            finished(models: nil, error: error)
            
        }
    }
    
    class func cacheStatusImages(list: [Statuses], finished: (models:[Statuses]?,error:NSError?) -> ()) {
        print("abc".cacheDir())
        //1.创建一个组
        let group = dispatch_group_create()
        for status in list {
            //1.1判断当前微博是否有配图，如果没有就直接跳过
            //            if status.storedPicURLS == nil {
            //                continue
            //            }
            //2.0新方法，如果条件为nil 就会执行else后面的语句
            guard let urls = status.storedPicURLS else
            {
                continue
            }
            for url in status.storedPicURLS! {
                //将当前的下载操作添加到组中
                dispatch_group_enter(group)
                //缓存图片
                SDWebImageManager.sharedManager().downloadWithURL(url, options: SDWebImageOptions(rawValue: 0), progress: nil, completed: { (_, _, _, _) in
                    print("缓存图片OK")
                    //离开组
                    dispatch_group_leave(group)
                })
                
            }
        }
        dispatch_group_notify(group, dispatch_get_main_queue()) { 
            //2.当所有的图片都下载完毕再通过闭包通知调用者
            finished(models: list, error: nil)
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
