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
            switch ve {
            case <#pattern#>:
                <#code#>
            default:
                <#code#>
            }
        }
    }
    //保存当前用户的认证图片
    var verifiedImage:UIImage?
    
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
