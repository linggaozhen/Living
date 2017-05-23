//
//  CollectionHeaderView.swift
//  LivingApplication
//
//  Created by ioser on 17/5/17.
//  Copyright © 2017年 ioser. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {

    @IBOutlet weak var tag_icon: UIImageView!
    
    @IBOutlet weak var tagName: UILabel!
    
    @IBOutlet weak var moreButton: UIButton!
    var groupMoel : AnchorGorup = AnchorGorup() {
        didSet{
            tagName.text = groupMoel.tag_name
            
        }
    }
    
    class func createHeaderView() -> CollectionHeaderView {
        return (NSBundle.mainBundle().loadNibNamed("CollectionHeaderView", owner: nil, options: nil).first as? CollectionHeaderView)!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
