//
//  pageContentView.swift
//  LivingApplication
//
//  Created by ioser on 17/5/15.
//  Copyright © 2017年 ioser. All rights reserved.
//

import UIKit

// 代理
protocol pageContentViewScrollerDelegate : class{
     func scrollerProgress(progress : CGFloat, beginIndext : Int, targetIndext : Int)
}

private let cellID = "collectionViewCellID"

class pageContentView: UIView{
    
    private var childViewCtlArray : [UIViewController] = [UIViewController]()
    private weak var parentViewController : UIViewController?
    private var mylayout : UICollectionViewFlowLayout?
    private var startOffSet : CGFloat = 0
    weak var scrollerDelegate : pageContentViewScrollerDelegate?
    var isforbitScroller = false
    
    
    // 懒加载
    lazy var collectionView : UICollectionView = {
        // 流水布局
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        self.mylayout = layout
        // CollectionView创建
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.pagingEnabled = true
        collectionView.scrollsToTop = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        return collectionView
    }()
    
    
    // 构造函数
    init(frame: CGRect, childViewController : [UIViewController], parentController : UIViewController) {
        super.init(frame: frame)
        childViewCtlArray = childViewController
        self.parentViewController = parentController
        
        //UI
        UISetting()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        collectionView.frame = self.bounds
        mylayout?.itemSize = self.bounds.size
    }
}

// MARK: - UI
extension pageContentView{
  
    private func UISetting(){
        
        collectionView.autoresizingMask = [.FlexibleHeight,.FlexibleWidth]
        addSubview(collectionView)
        
        // 给父控制器添加子控制器
        for controller in self.childViewCtlArray {
            self.parentViewController?.addChildViewController(controller)
        }
    }
}

// MARK: - collectionView dataSource方法

extension pageContentView : UICollectionViewDataSource{
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childViewCtlArray.count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as UICollectionViewCell
        
        let viewController = self.parentViewController?.childViewControllers[indexPath.item]
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        cell.contentView.addSubview((viewController?.view)!)
        return cell
        
    }
  
}
// MARK: - scrollView 代理方法
extension pageContentView : UICollectionViewDelegate{
    // 准备滚动时候调用
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        isforbitScroller = false
        startOffSet = scrollView.contentOffset.x
    }
    
    
    // 滚动时候时刻调用
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if isforbitScroller {return}
        var sourceIndext : Int = 0
        var targetIndext : Int = 0
        var progress : CGFloat = 0
        
        let currentOffset = scrollView.contentOffset.x
        
        if currentOffset >= startOffSet {// 左滑
            // 滚动进度
            progress = currentOffset / scrollView.frame.width - floor(currentOffset / scrollView.frame.width)
            
            // 开始索引
            sourceIndext = Int(currentOffset / scrollView.frame.width)
            // 目标索引
            targetIndext = sourceIndext + 1
            if targetIndext >= childViewCtlArray.count {
                targetIndext = childViewCtlArray.count - 1
            }
            //-------
            if currentOffset - startOffSet == scrollView.frame.width || currentOffset - startOffSet == 0 {
                progress = 1
                targetIndext = sourceIndext
            }
            //-------
        } else if currentOffset < startOffSet {// 右滑
            // 滚动进度
            progress = 1 - (currentOffset / scrollView.frame.width - floor(currentOffset / scrollView.frame.width))
            
            // 目标索引
            targetIndext = Int(currentOffset / scrollView.frame.width)
            // 开始索引
            sourceIndext = targetIndext + 1
            if sourceIndext >= childViewCtlArray.count {
                sourceIndext = childViewCtlArray.count - 1
            }
            
            //-----
            if startOffSet - currentOffset == scrollView.frame.width {
                sourceIndext = targetIndext
            }
            //-----
        }
        // 通过代理方法把参数传出去
        scrollerDelegate?.scrollerProgress(progress, beginIndext: sourceIndext, targetIndext: targetIndext)
    }
    

}

// titleLabel 点击时
extension pageContentView{
     func pageTitleLabelClick(indext : Int) {
        isforbitScroller = true
        let offsetPoint = CGPointMake(CGFloat(indext) * collectionView.frame.width, 0)
        collectionView.setContentOffset(offsetPoint, animated: false)
    }
}




