//
//  RecommerController.swift
//  LivingApplication
//
//  Created by ioser on 17/5/17.
//  Copyright © 2017年 ioser. All rights reserved.
//

import UIKit

private let margin : CGFloat = 10
private let layoutItemW : CGFloat = (KScreenW - margin * 3) / 2
private let layoutItemH : CGFloat = layoutItemW * 3 / 4
private let layoutPrettyItemH : CGFloat = layoutItemW * 4 / 3
private let CellID : String =  "collectionCellReuseCellID"
private let prettyCellID : String =  "PrettycollectionCellReuseCellID"
private let HeaderViewHeight : CGFloat = 50
private let headerRuserID = "headerID"


class RecommerController: UIViewController {
    
    /// 懒加载
    lazy var collectionView : UICollectionView = {
        
        // 流水布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: layoutItemW, height: layoutItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsetsMake(0, margin, 0, margin)
        layout.minimumInteritemSpacing = margin
        layout.headerReferenceSize = CGSize(width: KScreenW, height: HeaderViewHeight)
        
        // 创建collectionView
        let AcollectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        // 注册cell
        AcollectionView.registerNib(UINib(nibName: "NormalCollectionCell", bundle: nil), forCellWithReuseIdentifier: CellID)
        AcollectionView.registerNib(UINib(nibName: "PrettyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: prettyCellID)
        AcollectionView.registerNib(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerRuserID)
        AcollectionView.backgroundColor = UIColor.whiteColor()
        return AcollectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.greenColor()
        
        setUI()
    }


 
}


extension RecommerController{
    private func setUI(){
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.FlexibleWidth,.FlexibleHeight]
        view.addSubview(collectionView)
    }
}

// MARK: - collectionView 数据源方法
extension RecommerController : UICollectionViewDataSource{
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 18
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        }
        return 4
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(prettyCellID, forIndexPath: indexPath)
            return cell
        }
        
        let NormalCell = collectionView.dequeueReusableCellWithReuseIdentifier(CellID, forIndexPath: indexPath)
        return NormalCell
        
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let cellHeader = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: headerRuserID, forIndexPath: indexPath)
        cellHeader.backgroundColor = UIColor.whiteColor()
        return cellHeader
    }
}

// MARK: - collectionView 的代理方法
extension RecommerController : UICollectionViewDelegateFlowLayout{

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: layoutItemW, height: layoutPrettyItemH)
        }
        return CGSize(width: layoutItemW, height: layoutItemH)
    }
}



