//
//  NormalCollectionCell.swift
//  LivingApplication
//
//  Created by ioser on 17/5/17.
//  Copyright © 2017年 ioser. All rights reserved.
//

import UIKit


class NormalCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak  var iconImageView: UIImageView!
    @IBOutlet weak var RoomNameLabel: UILabel!
    @IBOutlet weak var onLineButton: UIButton!
    @IBOutlet weak var nikNameButton: UIButton!
    
    var listRoom : RoomListModel? {
        didSet{
            guard let room = listRoom else {return}
            
            nikNameButton.setTitle(room.nickname, forState: .Normal)
            let url = NSURL(string: room.vertical_src)
            iconImageView.kf_setImageWithURL(url!)
            RoomNameLabel.text = listRoom?.room_name
            
            var onlineText = ""
            
            if listRoom?.online >= 10000 {
                onlineText = "\(room.online / 10000)万人在线"
            } else {
                onlineText = "\(room.online)人在线"
            }
            onLineButton.setTitle(onlineText, forState: .Normal)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = UIColor.whiteColor()
        iconImageView.layer.cornerRadius = 5
        iconImageView.layer.masksToBounds = true
    }

}
