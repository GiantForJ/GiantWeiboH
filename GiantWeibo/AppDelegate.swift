//
//  AppDelegate.swift
//  GiantWeibo
//
//  Created by SH15BG0110 on 16/4/22.
//  Copyright © 2016年 SH15BG0110. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        //设置导航条和工具条的外观
        //因为外观一旦设置全局有效  所以应该在程序进入时就设置
        UINavigationBar.appearance().tintColor = UIColor.orangeColor()
        UITabBar.appearance().tintColor = UIColor.orangeColor()
        
        // 创建window
        window = UIWindow(frame:UIScreen.mainScreen().bounds)
        window?.backgroundColor = UIColor.whiteColor()
        //设置根视图
        window?.rootViewController = NewfeatureCollectionView()
        //可视化
        window?.makeKeyAndVisible()

        return true
    }


}