//
//  UILabel+Category.swift
//  GiantWeibo
//
//  Created by SH15BG0110 on 16/4/28.
//  Copyright © 2016年 SH15BG0110. All rights reserved.
//

import UIKit

extension UILabel{
    /**
     快速创建UILabel
     
     - parameter color: 字体颜色
     - parameter font:  字体大小
     
     - returns: Label
     */
    class func createLabel(color: UIColor,fontSize: CGFloat) -> UILabel
    {
        let label = UILabel()
        label.textColor = color
        label.font = UIFont.systemFontOfSize(fontSize)
        return label
    }
}
