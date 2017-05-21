//
//  PrettyCollectionViewCell.swift
//  LivingApplication
//
//  Created by ioser on 17/5/17.
//  Copyright © 2017年 ioser. All rights reserved.
//

import UIKit
import Kingfisher

class PrettyCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var onLineButton: UIButton!
    @IBOutlet weak var cityButton: UIButton!
    @IBOutlet weak var NikNameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    var listRoomModel : RoomListModel? {
        didSet{
            guard let roomList = listRoomModel else {return}
            
            cityButton.setTitle(roomList.anchor_city, forState: .Normal)
            NikNameLabel.text = roomList.nickname
            let url = NSURL(string: roomList.vertical_src)
            iconImageView.kf_setImageWithURL(url!)
            
            var onlineText = ""
            if roomList.online > 10000 {
                onlineText = "\(roomList.online / 10000)万人在线"
            } else {
                onlineText = "\(roomList.online)人在线"
            }
            onLineButton.setTitle(onlineText, forState: .Normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        contentView.backgroundColor = UIColor.whiteColor()
    }

}
