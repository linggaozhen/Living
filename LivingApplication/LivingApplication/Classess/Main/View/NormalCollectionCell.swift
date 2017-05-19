//
//  NormalCollectionCell.swift
//  LivingApplication
//
//  Created by ioser on 17/5/17.
//  Copyright © 2017年 ioser. All rights reserved.
//

import UIKit

class NormalCollectionCell: UICollectionViewCell {
    @IBOutlet weak var backgroundImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = UIColor.whiteColor()
        backgroundImageView.layer.cornerRadius = 5
        backgroundImageView.layer.masksToBounds = true
    }

}
