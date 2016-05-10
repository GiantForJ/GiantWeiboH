//
//  StatusTableViewTopView.swift
//  GiantWeibo
//
//  Created by SH15BG0110 on 16/5/10.
//  Copyright © 2016年 SH15BG0110. All rights reserved.
//

import UIKit

class StatusTableViewTopView: UIView {
    
    var statys:Statuses?
        {
        didSet{
            nameLable.text = statys?.user?.name
            timeLabel.text = statys?.created_at
            //设置用户头像
            if let url = statys?.user?.imageURL {
                iconView.sd_setImageWithURL(url)
            }
            //设置认证图标
            verifiedView.image = statys?.user?.verifiedImage
            //设置会员图标
            vipView.image = statys?.user?.mbrankImage
            //设置来源
            sourceLabel.text = statys?.source
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //初始化UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        //1.添加子控件
        addSubview(iconView)
        addSubview(verifiedView)
        addSubview(nameLable)
        addSubview(vipView)
        addSubview(timeLabel)
        addSubview(sourceLabel)
        //2.布局子控件
        iconView.xmg_AlignInner(type: XMG_AlignType.TopLeft, referView: self, size: CGSize(width: 50,height: 50),offset: CGPoint(x: 10, y: 10))
        
        verifiedView.xmg_AlignInner(type: XMG_AlignType.BottomRight, referView: iconView, size: CGSize(width: 14, height: 14),offset: CGPoint(x: 5, y: 5))
        
        nameLable.xmg_AlignHorizontal(type: XMG_AlignType.TopRight, referView: iconView, size: nil,offset: CGPoint(x: 10, y: 0))
        
        vipView.xmg_AlignHorizontal(type: XMG_AlignType.TopRight, referView: nameLable, size: CGSize(width: 14, height: 14),offset: CGPoint(x: 10, y: 0))
        timeLabel.xmg_AlignHorizontal(type: XMG_AlignType.BottomRight, referView: iconView, size: nil,offset:  CGPoint(x: 10, y: 0))
        sourceLabel.xmg_AlignHorizontal(type: XMG_AlignType.BottomRight, referView: timeLabel, size: nil,offset:  CGPoint(x: 10, y: 0))
        
    }
    
    //MARK: - 懒加载
    /**
     *  头像
     */
    private lazy var iconView:UIImageView = {
        let iv = UIImageView(image: (UIImage(named: "avatar_default_big")))
        
        return iv
    }()
    /**
     *  认证图标
     */
    private lazy var verifiedView:UIImageView = UIImageView(image: UIImage(named: "avatar_enterprise_vip"))
    /**
     *  昵称
     */
    private lazy var nameLable: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGrayColor()
        label.font = UIFont.systemFontOfSize(14)
        return label
    }()
    /**
     *  会员图表
     */
    private lazy var vipView: UIImageView = UIImageView(image: UIImage(named: "common_icon_membership"))
    /**
     *  时间
     */
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGrayColor()
        label.font = UIFont.systemFontOfSize(14)
        return label
    }()
    /**
     *  来源
     */
    private lazy var sourceLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGrayColor()
        label.font = UIFont.systemFontOfSize(14)
        return label
    }()
    
    
    
    
}
