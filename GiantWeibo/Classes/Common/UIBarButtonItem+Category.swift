//
//  UIBarButtonItem+Category.swift
//  GiantWeibo
//
//  Created by SH15BG0110 on 16/4/22.
//  Copyright © 2016年 SH15BG0110. All rights reserved.
//

import UIKit

// MARK: - UIBarButtonItem 扩展方法
extension UIBarButtonItem{
    
    // 如果在func前面加上class 就相当于OC中的+
    class func  creatBarButtonItem(imageName:String,target:AnyObject?,action:Selector) ->UIBarButtonItem{
    
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), forState: UIControlState.Normal)
        
        btn.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        
        btn.setImage(UIImage(named:imageName + "_highlighted"), forState: UIControlState.Highlighted)
        btn.sizeToFit()
        return UIBarButtonItem(customView: btn)
    }
    
}
