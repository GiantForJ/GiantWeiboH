//
//  MainViewController.swift
//  GiantWeibo
//
//  Created by SH15BG0110 on 16/4/22.
//  Copyright © 2016年 SH15BG0110. All rights reserved.
//

import UIKit

/*
 command + j ->定位目录
 ⬆️⬇️选择文件夹
 按回车 -> command + c 拷贝文件名称
 command + n 创建文件
 */

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置当前控制器对应tabbar的颜色
        // iOS 7 之前如果设置了tintColor只有文字会变，图片不变
//        tabBar.tintColor = UIColor.orangeColor()
        
        //ios7 开始就不推荐大家在viewDidload中设置frame
        //添加子控制器
        addChildViewControllers()
       //            let dicArr = NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.MutableContainers)
            
        }
        
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
       //添加加号按钮
        setUpComposeBtn()
    }
    
    /**
     加号监听方法
     监听按钮点击的方法不能是私有的方法 因为它是运行时添加的方法 消息机制发送的
     */
    func composeBtnClick(){
        print(#function)
    }
    
    private func setUpComposeBtn(){
        //1.添加加号按钮
        tabBar.addSubview(composeBtn)
        
        //2.调整加号按钮的位置
        let width = UIScreen.mainScreen().bounds.size.width/CGFloat(viewControllers!.count)
//        let height = UIScreen.mainScreen().bounds.size.height
        
        let rect = CGRect(x: 0, y: 0, width: width , height: 49)
//        composeBtn.frame = rect
        //1:frame大小
        //2.x方向偏移的大小
        //3:y偏移
        composeBtn.frame = CGRectOffset(rect, 2 * width, 0)
        
        
    }
        
    
    

/**
 添加子视图控制器
 */
private func  addChildViewControllers(){
    /*
     //1.创建首页
     let home = HomeTableViewController()
     //        home.title = "首页"
     //1.1设置首页tabbar对应的数据
     home.tabBarItem.image = UIImage(named: "tabbar_home")
     home.tabBarItem.selectedImage = UIImage(named: "tabbar_home_highlighted")
     home.tabBarItem.title = "首页"
     
     //1.2 设置导航条对应的数据
     home.navigationItem.title = "首页"
     //2.给首页包装一个导航控制器
     let nav = UINavigationController()
     nav.addChildViewController(home)
     
     //3.将导航控制器添加到当前控制器上
     addChildViewController(nav)
     */
    
    //        addChildViewController(HomeTableViewController(), title: "首页", imageName: "tabbar_home")
    //        addChildViewController(MessageTableViewController(), title: "消息", imageName: "tabbar_message_center")
    //        addChildViewController(DiscoverTableViewController(), title: "广场", imageName: "tabbar_discover")
    //        addChildViewController(ProfileTableViewController(), title: "我", imageName: "tabbar_profile")
    
    //1.获取json文件的路径
    let path = NSBundle.mainBundle().pathForResource("MainVCSettings.json", ofType: nil)
    //2.通过文件路径创建NSData
    if let jsonPath = path {
        let jsonData = NSData(contentsOfFile: jsonPath)
        
        
        do{
            //有可能发生异常的代码
            //3.序列化json数据 -->Array
            //try:发生异常会跳到catch中继续执行
            //try!：发生异常程序直接崩溃
            let dictArr = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.MutableContainers)
            //                print(dictArr)
            
            //遍历数组，动态创建控制器和设置数据
            // swift 遍历数组 必须明确数据的类型
            for dict in dictArr  as!  [[String: String]]{
                
                //报错的原因 adddChildViewControler 参数必须有值，但字典的返回值是可选的
                addChildViewController(dict["vcName"]!, title: dict["title"]!, imageName: dict["imageName"]!)
                
            }
            
        }catch
        {
            //异常执行的代码
            print(error)
            
            //从本地创建控制器
            addChildViewController("HomeTableViewController", title: "首页", imageName: "tabbar_home")
            addChildViewController("MessageTableViewController", title: "消息", imageName: "tabbar_message_center")
            
            //再添加一个占位控制器
            addChildViewController("NullViewController", title: "", imageName: "")
            addChildViewController("DiscoverTableViewController", title: "广场", imageName: "tabbar_discover")
            addChildViewController("ProfileTableViewController", title: "我", imageName: "tabbar_profile")
        }
        
        /*
         //4.遍历数组动态创建
         
         addChildViewController("HomeTableViewController", title: "首页", imageName: "tabbar_home")
         addChildViewController("MessageTableViewController", title: "消息", imageName: "tabbar_message_center")
         addChildViewController("DiscoverTableViewController", title: "广场", imageName: "tabbar_discover")
         addChildViewController("ProfileTableViewController", title: "我", imageName: "tabbar_profile")
         */
}
}
    /**
     初始化子控制器
     
     - parameter childController: 需要初始化的子控制器
     - parameter title:           标题
     - parameter imageName:       子控制器的图片
     */
//    private func addChildViewController(childController: UIViewController,title:String,imageName:String) {
    
        private func addChildViewController(childControllerName: String,title:String,imageName:String) {
        
//        print(childController)
            //-1.动态获取命名空间
         let ns =   NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as! String
            //0.通过字符串转化为类
            //默认情况下命名空间就是项目的名称，但命名空间名称是可以修改的
            let cls:AnyClass? = NSClassFromString(ns+"."+childControllerName)
            
            //0.2通过类创建对象
            //0.2.1 将AnyClass转化为制定的类型
            let vcCls = cls as! UIViewController.Type
            //0.2.2通过class创建对象
            let vc = vcCls.init()
        
        //1.创建首页
//        let home = HomeTableViewController()
                vc.title = title
        //1.1设置首页tabbar对应的数据
        vc.tabBarItem.image = UIImage(named: imageName)
        vc.tabBarItem.selectedImage = UIImage(named: imageName + "_highlighted")
//        childController.tabBarItem.title = "首页"
        
        //1.2 设置导航条对应的数据
//        childController.navigationItem.title = "首页"
        //2.给首页包装一个导航控制器
        let nav = UINavigationController()
        nav.addChildViewController(vc)
        
        //3.将导航控制器添加到当前控制器上
        addChildViewController(nav)
 
    }
    
    //MARK: - 懒加载/
    private lazy var composeBtn: UIButton  = {
        let btn = UIButton()
        
        //2.设置前景图片
        btn.setImage(UIImage(named:"tabbar_compose_icon_add"), forState: UIControlState.Normal)
        btn.setImage(UIImage(named:"tabbar_compose_icon_add_highlighted"), forState: UIControlState.Highlighted)
        
        //3.设置背景图片
        btn.setBackgroundImage(UIImage(named:"tabbar_compose_button"), forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage(named:"tabbar_compose_button_highlighted"), forState: UIControlState.Highlighted)
        
        //4.添加监听
        btn.addTarget(self, action: #selector(MainViewController.composeBtnClick), forControlEvents: UIControlEvents.TouchUpInside)
        return btn
    }()

}
