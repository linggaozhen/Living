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
    lazy var DataSourceArray : [AnchorGorup] = [AnchorGorup]()
    lazy var cycyleArrayData : [CycleModel] = [CycleModel]()
    lazy var cyclyeView : CycleView = {
        let cyView = CycleView.createCycleView()
        return cyView
    }()
    // 游戏推荐View
    private lazy var gameView : RecommerGameView = {
        let gView = RecommerGameView.CreaterecommerGameView()
        gView.frame = CGRect(x: 0, y: -gameViewH, width: KScreenW, height: gameViewH)
        return gView
    }()
    
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
        requestData()
    }


 
}

extension RecommerController{
    private func requestData(){
        // 请求推荐标签的数据
        HomeViewModel.loadRecommerData { (modelArray) in
            self.DataSourceArray = modelArray
            self.collectionView.reloadData()
            self.gameView.gameGroupData = modelArray
        }
        // 请求轮播图的数据
       HomeViewModel.loadCycleData { (responeArray) in
            self.cycyleArrayData = responeArray
            self.cyclyeView.modelArray = self.cycyleArrayData
        }
    }
}


// MARK: - UISetting
extension RecommerController{
    private func setUI(){
        
        collectionView.dataSource = self
        collectionView.delegate = self
//        collectionView.autoresizingMask = [.FlexibleWidth,.FlexibleHeight]
        collectionView.contentInset = UIEdgeInsetsMake(CycleViewH + gameViewH, 0, 160, 0)
        // 添加显示推荐标签模块的空间CollectionView
        view.addSubview(collectionView)
        
        // 添加无限滚动View
        collectionView.addSubview(self.cyclyeView)
        // 添加gameView
        collectionView.addSubview(gameView)
        
    }
}

// MARK: - collectionView 数据源方法
extension RecommerController : UICollectionViewDataSource{
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return self.DataSourceArray.count
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return self.DataSourceArray[section].arrayForRoomListModel.count
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let roomListModel = self.DataSourceArray[indexPath.section].arrayForRoomListModel[indexPath.item]
        
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(prettyCellID, forIndexPath: indexPath) as? PrettyCollectionViewCell
            cell!.listRoomModel = roomListModel
            return cell!
        }
        
        let NormalCell = collectionView.dequeueReusableCellWithReuseIdentifier(CellID, forIndexPath: indexPath) as? NormalCollectionCell
        NormalCell!.listRoom = roomListModel
        return NormalCell!
        
    }
    
    // HeaderView
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        // 创建View
        let cellHeader = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: headerRuserID, forIndexPath: indexPath) as? CollectionHeaderView
        // 设置view的属性和数据
        cellHeader?.groupMoel = self.DataSourceArray[indexPath.section]
        cellHeader!.backgroundColor = UIColor.whiteColor()
        return cellHeader!
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



