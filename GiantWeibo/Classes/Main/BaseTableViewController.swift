//
//  BaseTableViewController.swift
//  GiantWeibo
//
//  Created by SH15BG0110 on 16/4/22.
//  Copyright © 2016年 SH15BG0110. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController,VisitorViewDelegate {

    //定义一个变量保存用户是否登录
    var userLogin = false
    //定义属性保存未登录界面
    var viditorView: VisitorView?
    override func loadView() {
        
        userLogin ? super.loadView() : setupVisitorView()
     
        
    }
    //MARK: - 内部控制方法
    /**
     创建未登录界面
     */
   private  func setupVisitorView(){
    
    //1.初始化未登录界面
        let customView = VisitorView()
    customView.delegate = self
//        customView.backgroundColor = UIColor.blueColor()
        view = customView
    
    viditorView = customView
    //2.设置导航条未登录按钮
//    navigationController?.navigationBar.tintColor = UIColor.orangeColor()
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(BaseTableViewController.registerBtnWillClick))
    
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(BaseTableViewController.loginBtnWillClick))
    
    }
    
    //MARK: - 
    
    func loginBtnWillClick() {
        print(#function)
    }
    
    func registerBtnWillClick() {
        print(#function)
    }
    
}