//
//  GameCollectionViewCell.swift
//  LivingApplication
//
//  Created by ioser on 17/5/22.
//  Copyright © 2017年 ioser. All rights reserved.
//

import UIKit

class GameCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var dataModel : AnchorGorup? {
        didSet{
            titleLabel.text = dataModel?.tag_name
            iconImageView.kf_setImageWithURL(NSURL(string: (dataModel?.icon_url)!)!, placeholderImage: UIImage.init(named: "home_more_btn"))
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        iconImageView.layer.cornerRadius = iconImageView.bounds.width / 2
        iconImageView.layer.masksToBounds = true
    }

}
