//
//  PopoverAnimator.swift
//  GiantWeibo
//
//  Created by SH15BG0110 on 16/4/25.
//  Copyright © 2016年 SH15BG0110. All rights reserved.
//

import UIKit

let XMGPopverAnimatorWillShow = "XMGWillShow"
let XMGPopverAnimatorWillDissMiss  = "XMGWillDissMiss"

//代理
//protocol PopoverAnimatorDelgate:NSObjectProtocol {
//    func willPresent() ;
//    func willDismiss();
//}

class PopoverAnimator: NSObject ,UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning{
    
    //默认当前展开
    var isPresent: Bool? = false
    
    /// 定义属性保存菜单的大小
    var presentFrame = CGRectZero
    
    //实现代理方法，告诉系统谁负责转场动画
    //UIPresentationController? iOS8 退出的专门负责转场动画的
    @available(iOS 8.0, *)
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        
        let pc =  PopoverPresentationController(presentedViewController: presented, presentingViewController: presenting)
        //设置菜单大小
        pc.presentFrame = presentFrame
        return pc
    }
    
    //MARK: - 只要实现了以下方法，那么系统自带的默认动画就没有了，所有东西都需要自己来实现
    /**
     告诉系统谁来负责Moda的展现动画
     
     - parameter presented:  被展现视图
     - parameter presenting: 发起的视图
     - parameter source:     <#source description#>
     
     - returns:谁来负责
     */
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        isPresent = true
        //发送通知，通知控制器即将展开
        NSNotificationCenter.defaultCenter().postNotificationName(XMGPopverAnimatorWillShow, object: self, userInfo: nil)
        return self
    }
    
    /**
     告诉系统谁来负责model的消失动画
     
     - parameter dismissed: 被关闭的视图
     
     - returns: 谁来负责
     */
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        isPresent = false
        //发送通知 通知控制器即将消失
        NSNotificationCenter.defaultCenter().postNotificationName(XMGPopverAnimatorWillDissMiss, object: self, userInfo: nil)
        return self
    }
    
    //MARK: -UIViewControllerAnimatedTransitioning
    
    /**
     返回动画时长
     
     - parameter transitionContext: 上下文  保存了动画需要的所有参数
     
     - returns: 动画时长
     */
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    
    /**
     告诉系统如何动画  无论展现还是消失 都会调用这个方法
     
     - parameter transitionContext: 上下文  保存了动画需要的所有参数
     */
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        //1.拿到展现视图
        /*
         let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
         let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
         */
        if isPresent!  {
            
            //展开
            let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
            toView.transform = CGAffineTransformMakeScale(1.0, 0.0)
            //注意:一定要将视图添加到容器上
            transitionContext.containerView()?.addSubview(toView)
            // 设置锚点  会从上之下展开
            toView.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
            //2.执行动画
            UIView.animateWithDuration(transitionDuration(transitionContext), animations: {
                //2.1清空transform 展开
                toView.transform = CGAffineTransformIdentity
            }) { (_) -> Void in
                //2.2 动画执行完毕，告诉系统必须的
                //如果不写  可能导致一些位置错误
                transitionContext.completeTransition(true)
            }
            
        } else {
            let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)
            
            UIView.animateWithDuration(transitionDuration(transitionContext), animations: {
                //注意:由于CGFloat是不准确的 ，所以如果写0.0会没有动画
                //压扁
                fromView?.transform = CGAffineTransformMakeScale(1.0, 0.00000001)
                }, completion: { (_) in
                    //2.2 动画执行完毕，告诉系统必须的
                    //如果不写  可能导致一些位置错误
                    transitionContext.completeTransition(true)
            })
            
        }
        
    }
    
}

