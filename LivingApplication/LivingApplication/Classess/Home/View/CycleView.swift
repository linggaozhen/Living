//
//  CycleView.swift
//  LivingApplication
//
//  Created by ioser on 17/5/21.
//  Copyright © 2017年 ioser. All rights reserved.
//

import UIKit

private let cycleViewCellID = "cycleViewCellID"

class CycleView: UIView {

    @IBOutlet weak var pageView: UIPageControl!
    
    @IBOutlet weak var CollectionView: UICollectionView!
    
    // 定时器
    var timer : NSTimer?
    
    
    // 数组 保存了所有数据
    var modelArray : [CycleModel]? {
        didSet{
            guard let dataArray = modelArray else {return}
            pageView.numberOfPages = dataArray.count
            CollectionView.reloadData()
            let indextpath = NSIndexPath(forItem: dataArray.count * 100, inSection: 0)
            
            CollectionView.scrollToItemAtIndexPath(indextpath, atScrollPosition: .Left, animated: false)
            
            addTimer()
        }
    }
    
    
    
    override func awakeFromNib() {
        
        // 设置collectionView属性
        CollectionView.pagingEnabled = true
        CollectionView.registerNib(UINib(nibName: "CycleCollectionViewCell",bundle: nil), forCellWithReuseIdentifier: cycleViewCellID)
        CollectionView.backgroundColor = UIColor.clearColor()
        pageView.numberOfPages = 0
        CollectionView.showsHorizontalScrollIndicator = false
        CollectionView.dataSource = self
        CollectionView.delegate = self
        CollectionView.bounces = false
       
        
//        autoresizingMask = UIViewAutoresizing()
    }

    // 给外界提供的快速创建这个View的方法
    class func createCycleView() -> CycleView
    {
        return (NSBundle.mainBundle().loadNibNamed("CycleView", owner: nil, options: nil).first as? CycleView)!
    }
    
    // 设置frame值
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame = CGRect(x: 0, y: -(CycleViewH + gameViewH), width: KScreenW, height: CycleViewH)
        
        // 设置collectionView的layoutItem大小
        let layout = CollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CollectionView.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .Horizontal
        
        
    }
}

// MARK: - 数据源方法
extension CycleView : UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ((modelArray?.count) ?? 0) * 10000
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cycleViewCellID, forIndexPath: indexPath) as? CycleCollectionViewCell
        cell?.model = modelArray![indexPath.item % (modelArray?.count ?? 1)]
        return cell!
        
    }
}

// MARK: - 代理方法
extension CycleView : UICollectionViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        pageView.currentPage = Int(offset / scrollView.bounds.width) % (modelArray?.count ?? 1)
        
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        removerTimer()
    }
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        removerTimer()
        addTimer()
    }
}


// 定时器方法
extension CycleView {
    
    private func addTimer(){
        timer = NSTimer(timeInterval: 3.0, target: self, selector: #selector(scrollToNext), userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(timer!, forMode: NSRunLoopCommonModes)
    }
    
    private func removerTimer(){
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func scrollToNext(){
        let currentoffset = CollectionView.contentOffset.x
        let offset = currentoffset + CollectionView.frame.width
        CollectionView.setContentOffset(CGPoint(x: offset,y: 0), animated: true)
    }
}






