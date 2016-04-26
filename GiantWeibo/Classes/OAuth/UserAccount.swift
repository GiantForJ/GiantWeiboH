//
//  UserAccount.swift
//  GiantWeibo
//
//  Created by SH15BG0110 on 16/4/26.
//  Copyright © 2016年 SH15BG0110. All rights reserved.
//

import UIKit

//Swift 2.0 打印对象需要重写CustomStringConvertible..协议中的description
class UserAccount: NSObject ,NSCoding{
 
    var access_token:String?
    var expires_in: NSNumber?
    var uid:String?
    override init() {
        
    }
    init(dict: [String: AnyObject])
    {
        access_token = dict["access_token"] as? String
        expires_in = dict["expires_in"] as? NSNumber
        uid = dict["uid"] as? String
        
    }
    
    override var description: String{
        //1.定义属性数组
        let properties = ["access_token","expires_in","uid" ]
        //1.根据属性数组，将属性转换为字典
      let dict =  self.dictionaryWithValuesForKeys(properties)
        //3.
        return "\(dict)"
    }
    
   class  func userLogin() ->Bool{
        return UserAccount.loadAccount() != nil
    }
    
    //MARK: - 保存和读取 keyed
    /**
     保存授权模型
     */
    func saveAccount(){
    let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).last!
    let filePath = (path as NSString).stringByAppendingPathComponent("account.plist")
        print("filePath\(filePath)")
        NSKeyedArchiver.archiveRootObject(self, toFile: filePath)
        }
    /**
     加载授权模型
     */
    static var account: UserAccount?
    class func loadAccount() ->UserAccount?{
        //1.判断是否已经加载过
        if account != nil {
            return account
        }
        //1.加载授权模型
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).last!
        let filePath = (path as NSString).stringByAppendingPathComponent("account.plist")
        print("filePath \(filePath)")
       account =  NSKeyedUnarchiver.unarchiveObjectWithFile(filePath) as? UserAccount
        print(account)
        return account
    }
    
    //MARK: -NSCoding
    //将对象写入文件中
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(access_token,forKey: "access_token")
        aCoder.encodeObject(expires_in,forKey: "expires_in")
        aCoder.encodeObject(uid,forKey: "uid")
    }
    
    //从文件中读取对象
     required init?(coder aDecoder: NSCoder) {
        access_token = aDecoder.decodeObjectForKey("access_token") as? String
        expires_in = aDecoder.decodeObjectForKey("expires_in") as? NSNumber
        uid = aDecoder.decodeObjectForKey("uid") as? String
    }
    
}
