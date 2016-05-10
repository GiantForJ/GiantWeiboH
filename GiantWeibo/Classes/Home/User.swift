//
//  User.swift
//  GiantWeibo
//
//  Created by SH15BG0110 on 16/4/28.
//  Copyright © 2016年 SH15BG0110. All rights reserved.
//

import UIKit

class User: NSObject {
    var id: Int = 0
    var name: String?
    var  profile_image_url: String?
        {
        didSet{
            if let urlStr = profile_image_url {
                imageURL = NSURL(string: urlStr)
            }
            
        }
    }
    //用于头像的URL
    var imageURL: NSURL?
    var verified: Bool = false
    var verified_type: Int = -1 {
        didSet{
            switch verified_type {
            case 0:
                verifiedImage = UIImage(named: "avatar_vip")
            case 2, 3, 5:
                verifiedImage = UIImage(named: "avatar_enterprise_vip")
            case 220:
                verifiedImage = UIImage(named: "avatar_grassroot")
            default:
                verifiedImage = nil
                
            }
        }
    }
    //保存当前用户的认证图片
    var verifiedImage:UIImage?
    
    //保存当前用户的会员等级.KVC基本数据类型需要赋值，否则会无值
    var mbrank: Int = 0
        {
        didSet{
            if mbrank > 0 && mbrank < 7 {
                mbrankImage = UIImage(named: "common_icon_membership_level" + "\(mbrank)")
            }
        }
    }
    var mbrankImage: UIImage?
    
    //字典转模型
    init(dicr: [String: AnyObject]) {
        super.init()
        setValuesForKeysWithDictionary(dicr)
    }
    
    /**
     不一一对应
     */
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
        
    }
    //打印当前模型
    var properties = ["id","name","profile_image_url","verified","verified_type"];
    override var description: String {
        let dict = dictionaryWithValuesForKeys(properties)
        
        return "\(dict)"
        
    }
    
    
}
