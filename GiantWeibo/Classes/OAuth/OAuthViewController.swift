//
//  OAuthViewController.swift
//  GiantWeibo
//
//  Created by SH15BG0110 on 16/4/26.
//  Copyright © 2016年 SH15BG0110. All rights reserved.
//

import UIKit

class OAuthViewController: UIViewController {

    let WB_App_KEY = "23154210"
    let WB_App_Secret = "8a156454204d15c2fb375d92c7c47153"
    let WB_redirect_url = "http://www.520it.com"
    
    
    
    /**
     替换View为webView
     */
    override func loadView() {
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //0.初始化导航条
        navigationItem.title = "帅猪猪微博"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "关闭", style: UIBarButtonItemStyle.Plain, target: self, action: "close")
        
        //1.获取未授权的RequestToken
        let urlStr = "https://api.weibo.com/oauth2/authorize?client_id=\(WB_App_KEY)&redirect_uri=\(WB_redirect_url)"
        
        let url = NSURL(string: urlStr)
        let request = NSURLRequest(URL: url!)
        
        webView.loadRequest(request)
        
    }
    
    func close()  {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: - 懒加载
    private lazy var webView:UIWebView = {
        let wv = UIWebView()
        wv.delegate = self
        return wv
    }()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension OAuthViewController:UIWebViewDelegate{
    //如果返回true正常加载  返回false不加载
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        //加载授权界面
        //https://api.weibo.com/oauth2/authorize?client_id=23154210&redirect_uri=http://www.520it.com
        //授权成功
//        Optional("http://www.520it.com/?code=1ede87f6eed04a6548898be4a63093bb")
        //取消授权
//        "http://www.520it.com/?error_uri=%2Foauth2%2Fauthorize&error=access_denied&error_description=user%20denied%20your%20request.&error_code=21330")
//        print(request.URL?.absoluteString)
        
        //1.判断是否是授权回调页面，如果不是就继续加载
        let urlStr = request.URL!.absoluteString
        
        if !(request.URL!.absoluteString.hasPrefix(WB_redirect_url)) {
            //继续加载
            return true
        }
        
        //2.判断是否授权成功
        let codeStr = "code="
        //取
        if request.URL!.query!.hasPrefix(codeStr) {
            //授权成功
            print("授权成功")
            //1.取出已经授权的RequestToken
            //(codeStr.endIndex) 是从codeStr之后的位置取字符串
       let code =   request.URL!.query?.substringFromIndex(codeStr.endIndex)
            print(code)
            
            //2.利用已经授权的RequestToken换区accessToken
            loadAccessToken(code!)
        } else {
            //取消授权
            print("取消授权")
            close()
        }
        
        return false
    }
    
    /**
     换区accessToken
     
     - parameter code: 已经授权的accessToken  
     */
    private func loadAccessToken(code: String){
        //1.定义路径
        let path = "oauth2/access_token"
        //2.封装参数
        let params = ["client_id":WB_App_KEY,"client_secret":WB_App_Secret,"grant_type":"authorization_code","code":code,"redirect_uri":WB_redirect_url]
        //3.发送POST请求
        NetworkTools.shareNetworkTools().POST(path, parameters: params, success: { (_, JSON) in
         //JSON转Data
//            let data = NSJSONSerialization.dataWithJSONObject(JSON, options: NSJSONWritingOptions.PrettyPrinted)
//            let str = NSString(data: data, encoding: NSUTF8StringEncoding)
            print(JSON)
            //同一用户对同一个应用程序授权多次access_token是一样的 有过期时间
            //"access_token" = "2.004lDN3G0ATJZB63f16e6bc2Agn12C";
            //字典转模型
            /*
             plist:只能存储系统自带的数据类型
             将对象转换为json之后写入文件中
             */
            let account = UserAccount(dict: JSON as! [String:AnyObject])
            print(account)
            
            }) { (_, error) in
                print(error)
        }
        
        
    }
    
}
