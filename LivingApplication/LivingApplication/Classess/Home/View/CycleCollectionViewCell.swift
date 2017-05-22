//
//  CycleCollectionViewCell.swift
//  LivingApplication
//
//  Created by ioser on 17/5/21.
//  Copyright © 2017年 ioser. All rights reserved.
//

import UIKit

class CycleCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var picImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    var model : CycleModel?{
        didSet{
            guard let gmodel = model else {return}
            titleLabel.text = gmodel.title
            let url = NSURL(string: gmodel.pic_url)
            picImageView.kf_setImageWithURL(url!)
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = UIColor.clearColor()
    }

}
