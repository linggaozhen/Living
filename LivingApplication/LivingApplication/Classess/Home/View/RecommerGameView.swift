//
//  RecommerGameView.swift
//  LivingApplication
//
//  Created by ioser on 17/5/22.
//  Copyright © 2017年 ioser. All rights reserved.
//

import UIKit

private let gameCollectionCellID = "gameCollectionCellID"

class RecommerGameView: UIView {
    
    @IBOutlet weak var gameColletionView: UICollectionView!
    
    var gameGroupData : [AnchorGorup]?{
        didSet{
            gameGroupData?.removeFirst()
            gameGroupData?.removeFirst()
            let moreAnchor = AnchorGorup()
            moreAnchor.tag_name = "更多"
            gameGroupData?.append(moreAnchor)
            gameColletionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        gameColletionView.dataSource = self
        let layout = gameColletionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.itemSize = CGSize(width: 80, height: 90)
        layout?.scrollDirection = .Horizontal
        gameColletionView.registerNib(UINib(nibName: "GameCollectionViewCell",bundle: nil), forCellWithReuseIdentifier: gameCollectionCellID)
    }
    
    class func CreaterecommerGameView() -> RecommerGameView {
        return (NSBundle.mainBundle().loadNibNamed("RecommerGameView", owner: nil, options: nil).first as? RecommerGameView)!
    }
}


extension RecommerGameView : UICollectionViewDataSource{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameGroupData?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(gameCollectionCellID, forIndexPath: indexPath) as? GameCollectionViewCell
        let anchorModel = gameGroupData![indexPath.item]
        cell?.dataModel = anchorModel
        return cell!
        
    }
}