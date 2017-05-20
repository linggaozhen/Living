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
    
    var groupMoel : AnchorGorup = AnchorGorup() {
        didSet{
            tagName.text = groupMoel.tag_name
            
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
