//
//  StatusTableViewCell.swift
//  GiantWeibo
//
//  Created by SH15BG0110 on 16/4/28.
//  Copyright © 2016年 SH15BG0110. All rights reserved.
//

import UIKit
import SDWebImage
let GYPicturViewforCellWithReuseIdentifier = "GYPicturViewforCellWithReuseIdentifier"

class StatusTableViewCell: UITableViewCell {
    /// 保存配图的宽度约束
    var picturWidthCons: NSLayoutConstraint?
    /// 保存配图的高度约束
    var picturHeightCons: NSLayoutConstraint?
    var statys:Statuses?
        {
        didSet{
            
            //设置顶部视图数据
            topView.statys = statys
            /// 正文
            contentLabel.text = statys?.text
            //设置配图的尺寸
            //1.1根据模型计算配图的尺寸
            //计算尺寸需要模型
            pictureView.statys = statys
            let size = pictureView.calculateImageSize()
            //1.2 设置配图的尺寸 (元祖)
            picturWidthCons?.constant = size.width
            picturHeightCons?.constant = size.height
            
        }
    }
    //自定义一个类需要重写init方法是  designated
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //初始化UI
        setupUI()
        
    }
    
    
    private func setupUI(){
        //1.添加子控件
        contentView.addSubview(topView)
        contentView.addSubview(contentLabel)
        contentView.addSubview(footerView)
        contentView.addSubview(pictureView)
        
        //2.布局子控件
        let width = UIScreen.mainScreen().bounds.size.width
        topView.xmg_AlignInner(type: XMG_AlignType.TopLeft, referView: contentView, size: CGSize(width: width, height: 60))
        contentLabel.xmg_AlignVertical(type: XMG_AlignType.BottomLeft, referView: topView, size: nil, offset: CGPoint(x: 10, y: 10))
        //        footerView.xmg_AlignInner(type: XMG_AlignType.BottomRight, referView: contentView, size: nil,offset: CGPoint(x: -10, y: -10))
        let cons =   pictureView.xmg_AlignVertical(type: XMG_AlignType.BottomLeft, referView: contentLabel, size: CGSizeZero, offset: CGPoint(x: 0, y: 10))
        picturWidthCons =  pictureView.xmg_Constraint(cons, attribute: NSLayoutAttribute.Width)
        picturHeightCons =  pictureView.xmg_Constraint(cons, attribute: NSLayoutAttribute.Height)
        
        footerView.xmg_AlignVertical(type: XMG_AlignType.BottomLeft, referView: pictureView, size: CGSize(width: width,height: 44), offset: CGPoint(x: -10, y: 10))
        //添加一个底部约束
        //TODO: 这个地方一个问题
        //        contentLabel.xmg_AlignInner(type: XMG_AlignType.BottomRight, referView: contentView, size: nil,offset: CGPoint(x: -10, y: -10))
    }
    
    /**
     用于获取行高
     */
    func rowHeight(status: Statuses) -> CGFloat
    {
        //1.为了能够调用didSet，计算配图的高度
        self.statys = status
        
        //2.强制更新界面
        self.layoutIfNeeded()
        //3.返回底部视图最大的Y值
        return CGRectGetMaxY(footerView.frame)
    }
    
    //MARK: - 懒加载
    private lazy var topView: StatusTableViewTopView = StatusTableViewTopView()
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
    /// 配图
    private lazy var pictureView: StatusPictureView = StatusPictureView()
    /// 底部工具条
    private lazy var footerView: StatusTableViewBootomView = StatusTableViewBootomView()
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



