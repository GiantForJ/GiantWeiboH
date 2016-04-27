//
//  AppDelegate.swift
//  GiantWeibo
//
//  Created by SH15BG0110 on 16/4/22.
//  Copyright © 2016年 SH15BG0110. All rights reserved.
//

import UIKit

let GYSwiftRootViewControllerKey = "dbawuodua"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        //注册通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "switfhRootViewController:", name: GYSwiftRootViewControllerKey, object: nil)
        
        //设置导航条和工具条的外观
        //因为外观一旦设置全局有效  所以应该在程序进入时就设置
        UINavigationBar.appearance().tintColor = UIColor.orangeColor()
        UITabBar.appearance().tintColor = UIColor.orangeColor()
        
        // 创建window
        window = UIWindow(frame:UIScreen.mainScreen().bounds)
        window?.backgroundColor = UIColor.whiteColor()
        //设置根视图
        window?.rootViewController = defaultController()
        //可视化
        window?.makeKeyAndVisible()

        isNewupdate()
        return true
    }
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func switfhRootViewController(notify:NSNotification) {
        //        notify.object÷
        if ((notify.object as? Bool) != nil) {
            window?.rootViewController = MainViewController()
        } else {
            window?.rootViewController = WelcomeViewController()
        }
        
    }
    
    /**
     用于确认返回的默认界面
     
     - returns: 默认界面
     */
    private func defaultController() -> UIViewController{
        if UserAccount.userLogin() {
            return    isNewupdate() ? NewfeatureCollectionView() : WelcomeViewController()
        }
        return MainViewController()
    }
    
    private func isNewupdate()  -> Bool{
        //1.获取当前软件的版本号 --》 info.plist
        let currenVeision =   NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"] as! String
        //2.获取以前的软件版本号 -》从本地文件中读取(以前自己存储的)
        
        //3.比较当前版本号和以前版本号
        let  sandBoxVersion = NSUserDefaults.standardUserDefaults().objectForKey("CFBundleShortVersionString") as? String ?? ""
        //        if sandBoxVersion == nil {
        //            sandBoxVersion = ""
        //        }
        
        print("当前 =\(currenVeision),最新 =\(sandBoxVersion)")
        //3如果当前>以前  有新版本
        
        
        if currenVeision.compare(sandBoxVersion) == NSComparisonResult.OrderedDescending {
            //iOS 7 之后不需要同步方法
            NSUserDefaults.standardUserDefaults().setObject(currenVeision, forKey: "CFBundleShortVersionString")
            return true
        }
        //3.1.1 存储当前最新的版本号
        
        return true
    }
    
    
}