//
//  GameViewController.swift
//  LivingApplication
//
//  Created by ioser on 17/5/22.
//  Copyright © 2017年 ioser. All rights reserved.
//------------------------首页‘游戏’控制器--------------------

import UIKit

private let margin : CGFloat = 10
private let gameItemW = (KScreenW - 2 * margin) / 3
private let gameItemH = gameItemW * 6 / 5
private let gameCollectionCellID = "gameCollectionCellID"
private let headerRuserID = "headerID"
private let KTopHeaderViewH : CGFloat = 50
private let KTopGameViewH : CGFloat = 90

class GameViewController: UIViewController {
    
    
    private var dataSourecArray : [GameModel] = [GameModel]()
    
    // 创建headerView
    lazy var topHeaderView : CollectionHeaderView = {
        let headerView = CollectionHeaderView.createHeaderView()
        headerView.frame = CGRect(x: 0, y: -(KTopHeaderViewH + KTopGameViewH), width: KScreenW, height: KTopHeaderViewH)
        headerView.tag_icon.image = UIImage.init(named: "Img_orange")
        headerView.tagName.text = "常见"
        headerView.moreButton.hidden = true
        return headerView
    }()
    // 创建显示游戏的滚动View
    lazy var showGameContentView : RecommerGameView = {
        let gameView = NSBundle.mainBundle().loadNibNamed("RecommerGameView", owner: nil, options: nil).first as? RecommerGameView
        gameView?.frame = CGRect(x: 0, y: -KTopGameViewH, width: KScreenW, height: KTopGameViewH)
        gameView!.backgroundColor = UIColor.redColor()
        return gameView!
    }()

    lazy private var gameCollectionView : UICollectionView = {
        
        // layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: gameItemW, height: gameItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsetsMake(0, margin, 0, margin)
        layout.headerReferenceSize = CGSize(width: KScreenW, height: 40)
        // colllectionView
        let CLTV = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        CLTV.registerNib(UINib(nibName: "GameCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: gameCollectionCellID)
        CLTV.registerNib(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerRuserID)
        CLTV.backgroundColor = UIColor.whiteColor()
        return CLTV
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UISetting()
        requestGameData()
    }

}

// MARK: - 请求数据
extension GameViewController {
    private func requestGameData() {
        HomeViewModel.loadGameData { (modelArray) in
            self.dataSourecArray = modelArray
            self.showGameContentView.gameControllerData = modelArray
            self.gameCollectionView.reloadData()
        }
    }
}

// MARK: - UI
extension GameViewController {
    private func UISetting() {
        // 添加CollectionView
        gameCollectionView.frame = view.bounds
        gameCollectionView.dataSource = self
        view.addSubview(gameCollectionView)
        
        // 顶部HeaderView
        gameCollectionView.addSubview(topHeaderView)
        gameCollectionView.contentInset = UIEdgeInsetsMake(KTopHeaderViewH + KTopGameViewH, 0, 0, 0)
        
        // 顶部游戏View
        gameCollectionView.addSubview(showGameContentView)
        
    }
}

// MARK: - DataSource 方法
extension GameViewController : UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSourecArray.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(gameCollectionCellID, forIndexPath: indexPath) as? GameCollectionViewCell
        let model = self.dataSourecArray[indexPath.item]
        cell?.titleLabel.text = model.tag_name
        let url = NSURL(string: model.icon_url)
        cell?.iconImageView.kf_setImageWithURL(url!)
        return cell!
        
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: headerRuserID, forIndexPath: indexPath) as? CollectionHeaderView
        headerView?.moreButton.hidden = true
        headerView?.tagName.text = "游戏"
        headerView?.tag_icon.image = UIImage.init(named: "Img_orange")
        return headerView!
    }
}




