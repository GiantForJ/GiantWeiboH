//
//  HomeTableViewController.swift
//  GiantWeibo
//
//  Created by SH15BG0110 on 16/4/22.
//  Copyright © 2016年 SH15BG0110. All rights reserved.
//

import UIKit
import AFNetworking

let GYHomeResueIdentifier = "GYHomeResueIdentifier"

class HomeTableViewController: BaseTableViewController{
    
    /// 保存微博数组
    var statuses: [Statuses]?
        {
        didSet{
            //当别人设置完毕数据，就刷新表格
            tableView.reloadData()
        }
    }
    
    //command+ OPTION +SHIFT + 方向键
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //1.如果没有登录  设置未登录界面的信息
        if !userLogin {
            viditorView?.setupVisiorInfo(true, imageName:"visitordiscover_feed_image_house", message: "看看吧")
            //            return
        }
        
        //2.初始化导航条
        setupNav()
        
        //3.注册通知，监听菜单
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HomeTableViewController.change), name: XMGPopverAnimatorWillShow, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(HomeTableViewController.change), name: XMGPopverAnimatorWillDissMiss, object: nil)
        
        //注册一个cell
        tableView.registerClass(StatusTableViewCell.self, forCellReuseIdentifier: GYHomeResueIdentifier)
        //        tableView.rowHeight = 200
        //预估行高。tableView自动调节行高
        tableView.estimatedRowHeight = 200
        //        tableView.rowHeight = UITableViewAutomaticDimension
        //        tableView.rowHeight = 300
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        //4.加载微博数据
        loadData()
    }
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    /**
     获取微博数据
     */
    private func loadData(){
        Statuses.loadStatuses { (models, error) in
            if error != nil {
                return
            }
            self.statuses = models
            
        }
    }
    
    func change(){
        //修改标题按钮状态
        let titlBtn = navigationItem.titleView as! TitleButton
        titlBtn.selected = !titlBtn.selected
        
    }
    
    private func setupNav(){
        //        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "navigationbar_friendattention"), style: UIBarButtonItemStyle.Plain, target: nil, action: Selector(""))
        /*
         //        1.左边按钮
         let leftBtn = UIButton()
         leftBtn.setImage(UIImage(named: "navigationbar_friendattention"), forState: UIControlState.Normal)
         
         leftBtn.setImage(UIImage(named: "navigationbar_friendattention_highlighted"), forState: UIControlState.Highlighted)
         leftBtn.sizeToFit()
         navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
         
         //2.右边按钮
         // command + control + e
         let rigthBtn = UIButton()
         rigthBtn.setImage(UIImage(named: "navigationbar_pop"), forState: UIControlState.Normal)
         
         rigthBtn.setImage(UIImage(named: "navigationbar_pop_highlighted"), forState: UIControlState.Highlighted)
         rigthBtn.sizeToFit()
         navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rigthBtn)
         */
        //        navigationItem.rightBarButtonItem = creatBarButtonItem("navigationbar_friendattention",target: self,action: #selector(HomeTableViewController.leftItemClick))
        //        
        //        navigationItem.leftBarButtonItem = creatBarButtonItem("navigationbar_pop",target: self,action: #selector(HomeTableViewController.rightItemClick))
        //1.初始化左右的按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem.creatBarButtonItem("navigationbar_friendattention",target: self,action: #selector(HomeTableViewController.leftItemClick))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.creatBarButtonItem("navigationbar_pop",target: self,action: #selector(HomeTableViewController.rightItemClick))
        
        //2.初始化标题按钮
        let titleBtn = TitleButton()
        
        titleBtn.setTitle("帅猪猪", forState: UIControlState.Normal)
        titleBtn.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        //        titleBtn.setImage(UIImage(named: "navigationbar_arrow_down"), forState: UIControlState.Normal)
        //        titleBtn.setImage(UIImage(named: "navigationbar_arrow_up"), forState: UIControlState.Selected)
        //        titleBtn.sizeToFit()
        titleBtn.addTarget(self, action: #selector(HomeTableViewController.titleBtnClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        navigationItem.titleView  = titleBtn
    }
    
    func titleBtnClick(btn:TitleButton){
        //1.修改箭头的方向
        //        btn.selected = !btn.selected
        print(#function)
        //2.弹出菜单
        let sb = UIStoryboard(name: "PopverViewController", bundle: nil)
        let vc = sb.instantiateInitialViewController()
        //2.1设置转场代理
        //默认情况下modal回移除以前控制器的view，替换为当前弹出的view
        //如果自定义转场，那么就不去除以前控制器的view
        //        vc?.transitioningDelegate = self
        vc?.transitioningDelegate = popverAnimator
        //2.2设置转场的样式
        vc?.modalPresentationStyle = UIModalPresentationStyle.Custom
        presentViewController(vc!, animated: true, completion: nil)
        
        
    }
    
    func leftItemClick(){
        print(#function)
    }
    func rightItemClick(){
        //        print(#function) 
        let sb = UIStoryboard(name: "QRCoderViewController", bundle: nil)
        let vc = sb.instantiateInitialViewController()
        presentViewController(vc!, animated: true, completion: nil)
        
        
    }
    /**
     创建导航左右按钮
     
     - parameter imageName: 按钮图片
     
     - returns: UIBarButtonItem
     */
    private func creatBarButtonItem(imageName:String,target:AnyObject?,action:Selector) ->UIBarButtonItem
    {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), forState: UIControlState.Normal)
        
        btn.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        
        btn.setImage(UIImage(named:imageName + "_highlighted"), forState: UIControlState.Highlighted)
        btn.sizeToFit()
        return UIBarButtonItem(customView: btn)
    }
    
    //MARK： - 懒加载
    //一定要定义一个属性来负责转场动画
    private lazy var popverAnimator:PopoverAnimator = {
        let pa = PopoverAnimator()
        pa.presentFrame = CGRectMake(100, 56, 200, 200)
        return pa
        
    }()
    /// 微博行高的缓存  利用字典作为容器，key就是微博的id，值就是对应微博的行高
    var rowCache: [Int: CGFloat] = [Int: CGFloat]()
    
    override func didReceiveMemoryWarning() {
        //清空缓存
        rowCache.removeAll()
    }
}
extension HomeTableViewController
{
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statuses?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(GYHomeResueIdentifier) as! StatusTableViewCell
        let status = statuses![indexPath.row]
        cell.statys = status
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        //1.取出对应行的模型
        let status = statuses![indexPath.row]
        //2.判断缓存中是否有值
        if let height = rowCache[status.id] {
            return height
        }
        
        //3.拿到cell
        let cell = tableView.dequeueReusableCellWithIdentifier(GYHomeResueIdentifier) as! StatusTableViewCell
        //注意：不要使用以下方法获取，在某些版本或者模拟器会有bug
        //        tableView.dequeueReusableCellWithIdentifier(<#T##identifier: String##String#>, forIndexPath: <#T##NSIndexPath#>)
        //3.拿到对应的行高
        let rowHeight = cell.rowHeight(status)
        //4.缓存行高
        rowCache[status.id] = rowHeight
        //5.返回行高
        return rowHeight
        
    }
    
    
}


