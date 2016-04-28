//
//  StatusTableViewCell.swift
//  GiantWeibo
//
//  Created by SH15BG0110 on 16/4/28.
//  Copyright © 2016年 SH15BG0110. All rights reserved.
//

import UIKit
import SDWebImage
class StatusTableViewCell: UITableViewCell {
    
    var statys:Statuses?
        {
        didSet{
            //            textLabel?.text = statys?.text
            nameLable.text = statys?.user?.name
            timeLabel.text = "刚刚 "
            sourceLabel.text = "laizi：🐭a"
            contentLabel.text = statys?.text
            
            //设置用户头像
            if let url = statys?.user?.imageURL {
                iconView.sd_setImageWithURL(url)
            }
            //设置认证图标
            verifiedView.image = 
        }
    }
    
    //自定义一个类需要重写init方法是  designated
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //初始化UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        //1.添加子控件
        contentView.addSubview(iconView)
        contentView.addSubview(verifiedView)
        contentView.addSubview(nameLable)
        contentView.addSubview(vipView)
        contentView.addSubview(timeLabel)
        contentView.addSubview(sourceLabel)
        contentView.addSubview(contentLabel)
        contentView.addSubview(footerView)
        footerView.backgroundColor = UIColor(white: 0.2, alpha: 0.5)
        //2.布局子控件
        iconView.xmg_AlignInner(type: XMG_AlignType.TopLeft, referView: contentView, size: CGSize(width: 50,height: 50),offset: CGPoint(x: 10, y: 10))
        
        verifiedView.xmg_AlignInner(type: XMG_AlignType.BottomRight, referView: iconView, size: CGSize(width: 14, height: 14),offset: CGPoint(x: 5, y: 5))
        
        nameLable.xmg_AlignHorizontal(type: XMG_AlignType.TopRight, referView: iconView, size: nil,offset: CGPoint(x: 10, y: 0))
        
        vipView.xmg_AlignHorizontal(type: XMG_AlignType.TopRight, referView: nameLable, size: CGSize(width: 14, height: 14),offset: CGPoint(x: 10, y: 0))
        timeLabel.xmg_AlignHorizontal(type: XMG_AlignType.BottomRight, referView: iconView, size: nil,offset:  CGPoint(x: 10, y: 0))
        sourceLabel.xmg_AlignHorizontal(type: XMG_AlignType.BottomRight, referView: timeLabel, size: nil,offset:  CGPoint(x: 10, y: 0))
        contentLabel.xmg_AlignVertical(type: XMG_AlignType.BottomLeft, referView: iconView, size: nil, offset: CGPoint(x: 0, y: 19))
        //添加一个底部约束
        //TODO: 这个地方一个问题
        //        contentLabel.xmg_AlignInner(type: XMG_AlignType.BottomRight, referView: contentView, size: nil,offset: CGPoint(x: -10, y: -10))
        let width = UIScreen.mainScreen().bounds.size.width
        
        footerView.xmg_AlignVertical(type: XMG_AlignType.BottomLeft, referView: contentLabel, size: CGSize(width: width,height: 44), offset: CGPoint(x: -10, y: 10))
        footerView.xmg_AlignInner(type: XMG_AlignType.BottomRight, referView: contentView, size: nil,offset: CGPoint(x: -10, y: -10))
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
    /**
     *  正文
     */
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGrayColor()
        //最大宽度
        label.preferredMaxLayoutWidth = UIScreen.mainScreen().bounds.size.width - 20
        label.font = UIFont.systemFontOfSize(14)
        label.numberOfLines = 0
        return label
    }()
    /// 底部工具条
    private lazy var footerView: StatusFooterView = StatusFooterView()
}


class StatusFooterView: UIView {
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
        addSubview(retweetBtn)
        addSubview(unlikeBtn)
        addSubview(commonBtn)
        //2.布局子控件
        xmg_HorizontalTile([retweetBtn,unlikeBtn,commonBtn], insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        
    }
    
    //MARK: - 懒加载
    //转发
    private lazy var retweetBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "timeline_icon_retweet"), forState: UIControlState.Normal)
        btn.setTitle("转发", forState: UIControlState.Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(13)
        btn.setBackgroundImage(UIImage(named: "timeline_card_bottom_background"), forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        return btn
    }()
    
    private lazy var unlikeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "timeline_icon_unlike"), forState: UIControlState.Normal)
        btn.setTitle("赞", forState: UIControlState.Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(10)
        btn.setBackgroundImage(UIImage(named: "timeline_card_bottom_background"), forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        return btn
    }()
    
    private lazy var commonBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "timeline_icon_comment"), forState: UIControlState.Normal)
        btn.setTitle("评论", forState: UIControlState.Normal)
        btn.titleLabel?.font = UIFont.systemFontOfSize(10)
        btn.setBackgroundImage(UIImage(named: "timeline_card_bottom_background"), forState: UIControlState.Normal)
        btn.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        return btn
    }()
    
}
