//
//  MessageTableViewController.swift
//  GiantWeibo
//
//  Created by SH15BG0110 on 16/4/22.
//  Copyright © 2016年 SH15BG0110. All rights reserved.
//

import UIKit

class MessageTableViewController: BaseTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //1.如果没有登录  设置未登录界面的信息
        if !userLogin {
            viditorView?.setupVisiorInfo(false, imageName: "visitordiscover_image_message", message: "信息")
        }
    }
    
   
}
