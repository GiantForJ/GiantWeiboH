//
//  NewfeatureCollectionView.swift
//  GiantWeibo
//
//  Created by SH15BG0110 on 16/4/26.
//  Copyright © 2016年 SH15BG0110. All rights reserved.
//

import UIKit

private let reuseIdentifier = "reuseIdentifier"
class NewfeatureCollectionView: UICollectionViewController {

    //页面个数
    private let pageCount = 4
        /// 布局对象
    private var layout: UICollectionViewFlowLayout = NewfeatureLayout()
    //因为系统指定的初始化构造方法是带参数的（collectionViewLayout） 而不是不带参数的，所以不用写override
    init(){
        super.init(collectionViewLayout: layout)
    }
   
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //1.注册一个cell
        collectionView?.registerClass(NewfeaturCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //放在布局里设置
        /*
        //1.设置layput布局
        layout.itemSize = UIScreen.mainScreen().bounds.size
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        //2.设置collectionView属性
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.bounces = false
        collectionView?.pagingEnabled = true
      */
    }
    
    //MARK: -DataSource
    //1.返回多少个cell
        override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pageCount
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        //1.获取cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! NewfeaturCell
        
        //2.设置cell的数据
//        cell.backgroundColor = UIColor.redColor()
        cell.imageIndex = indexPath.row
        //3.返回cell
        
        return cell
    }
    
}
//Swift中一个文件可以定义多个类
private class NewfeaturCell:UICollectionViewCell{
    
        ///保存图片的索引
    //Swift 中被private修饰的东西  如果在同一个文件是可以访问的
    var imageIndex:Int? {
    didSet{
     iconView.image = UIImage(named: "new_feature_\(imageIndex! + 1)")
    }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //1.初始化UI
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        //1.添加子控件到contenView上
        contentView.addSubview(iconView)
        //2.布局子控件的位置
        iconView.xmg_Fill(contentView)
        
        
    }
    
    //MARK: - 懒加载
    private lazy var iconView = UIImageView()
}
class NewfeatureLayout: UICollectionViewFlowLayout {
    //准备布局
    //什么时候调用 1.先调用一个有多少行cell 2.2.调用准备布局  3.调用返回cell
    override func prepareLayout() {
        //1.设置layput布局
        itemSize = UIScreen.mainScreen().bounds.size
        minimumInteritemSpacing = 0
        minimumLineSpacing = 0
        scrollDirection = UICollectionViewScrollDirection.Horizontal
        
        //2.设置collectionView属性
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.bounces = false
        collectionView?.pagingEnabled = true
    }
}

