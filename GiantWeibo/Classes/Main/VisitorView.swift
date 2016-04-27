//
//  VisitorView.swift
//  GiantWeibo
//
//  Created by SH15BG0110 on 16/4/22.
//  Copyright © 2016年 SH15BG0110. All rights reserved.
//

import UIKit

// Swift中如何定义协议:必须遵守NSObjectProtocol
protocol VisitorViewDelegate:NSObjectProtocol{
    //登录的回调
    func loginBtnWillClick()
    
    //注册的回调
    func  registerBtnWillClick()
}

class VisitorView: UIView {
    
    //定义一个属性保存代理对象
    //一定要加上weak，避免循环引用
    weak var delegate:VisitorViewDelegate?
    
    /**
     设置未登录界面
     
     - parameter isHome:    是否是首页
     - parameter imageName: 图片
     - parameter message:   文本
     */
    func setupVisiorInfo(isHome:Bool,imageName:String,message:String)
    {
        //如果不是首页  隐藏转盘
        iconView.hidden = !isHome
        homeIcon.image = UIImage(named: imageName)
        //修改文本
        messageLabel.text = message
        
        // 判断是否需要执行动画
        if isHome {
            startAnimation()
        }
    }
    
    func loginBtnClick(){
        //        print(#function)
        delegate?.loginBtnWillClick()
    }
    
    func registerBtnClick(){
        //    print(#function)
        delegate?.registerBtnWillClick()
    }
    
    override  init(frame: CGRect) {
        super.init(frame: frame)
        
        //1.添加子控件
        addSubview(iconView)
        addSubview(maskBGView)
        addSubview(homeIcon)
        
        addSubview(messageLabel)
        addSubview(loginBtn)
        addSubview(registerBtn)
        //2.布局子控件
        //2.1设置背景
        iconView.xmg_AlignInner(type: XMG_AlignType.Center, referView: self, size: nil)
        //2.2设置房子
        homeIcon.xmg_AlignInner(type: XMG_AlignType.Center, referView: self, size: nil)
        
        //2.3设置文本
        messageLabel.xmg_AlignVertical(type: XMG_AlignType.BottomCenter, referView: iconView, size: nil)
        
        //"那个控件"  的 “什么属性” "等于"  "另外一个控件" 的 "什么属性" 乘以 "多少" 加上 "多少"
        addConstraint(NSLayoutConstraint(item: messageLabel, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1.0, constant: 224))
        //2.4 设置按钮
        registerBtn.xmg_AlignVertical(type: XMG_AlignType.BottomLeft, referView: messageLabel, size: CGSize(width: 100, height: 30),offset: CGPoint(x:0,y:20))
        
        loginBtn.xmg_AlignVertical(type: XMG_AlignType.BottomRight, referView: messageLabel, size: CGSize(width: 100, height: 30),offset: CGPoint(x:0,y:20))
        //2.5设置蒙版
        maskBGView.xmg_Fill(self)
        
    }
    
    //Swift 推荐我们自定义一个控件  纯代码/Xib、STOR
    required init?(coder aDecoder: NSCoder) {
        //如果通过xib创建该类，就会崩溃
        fatalError("请勿使用Xib")
    }
    
    //MARK： -内部控制方法
    private func startAnimation(){
        //1.创建动画
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        
        //2.设置动画属性
        anim.toValue = 2 * M_PI
        anim.duration = 20
        anim.repeatCount = MAXFLOAT
        //该属性默认为YEs  代表动画只要执行完毕就移除(放置界面切换转盘停止转动)
        anim.removedOnCompletion = false
        //3.将动画添加到涂层
        iconView.layer.addAnimation(anim, forKey: nil)
    }
    
    //MARK: -懒加载控件
    /// 转盘
    private lazy var iconView :UIImageView = {
        let iv = UIImageView(image:UIImage(named: "visitordiscover_feed_image_smallicon"))
        return iv
        
    }()
    /// 图标
    private lazy var homeIcon:UIImageView = {
        let iv = UIImageView(image:UIImage(named: "visitordiscover_feed_image_house"))
        return iv
        
    }()
    /// 文本
    private lazy var messageLabel: UILabel = {
        let iv = UILabel()
        iv.text = "dahidag地王对爱国断供的谷大股东噶骨法陕"
        iv.numberOfLines = 0;
        iv.textColor = UIColor.redColor()
        return iv
        
    }()
    /// 登录
    private lazy var loginBtn: UIButton = {
        let  btn = UIButton()
        btn.setTitle("登录", forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        btn.addTarget(self, action: #selector(VisitorView.loginBtnClick), forControlEvents: UIControlEvents.TouchUpInside)
        return btn
        
    }()
    /// 注册
    private lazy var registerBtn: UIButton = {
        let  btn = UIButton()
        
        btn.setTitle("注册", forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage(named:"common_button_white_disable"), forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        
        btn.addTarget(self, action: #selector(VisitorView.registerBtnClick), forControlEvents: UIControlEvents.TouchUpInside)
        return btn
        
    }()
    
    private lazy var maskBGView: UIImageView = {
        
        let iv = UIImageView(image:UIImage(named: "visitordiscover_feed_mask_smallicon"))
        
        return iv
        
    }()
}
